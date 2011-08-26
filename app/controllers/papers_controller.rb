class PapersController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:new, :create, :edit, :update, :destroy, :confirm_authors]
  before_filter :authenticate_role, 			:only => [:edit, :update, :destroy]
  
  def authenticate_role
	@paper = Paper.find(params[:id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@papers = Paper.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.save #update_attributes(params[:id])
	@experiments = @paper.experiments.all
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
  def new
	@paper = current_user.papers.build
	#@authors = Author.all
	respond_to do |format|
		format.html # new.html.erb
	end
  end

  def edit
    @authors = Author.all
	#@paper.authors.build
  end

  
  def create
    @paper = current_user.papers.create(params[:paper])
	@paper.num_views = 0
	i = 1
	1.upto(@paper.status) do
		temp = @paper.experiments.build
		temp.exp_type = 0
		temp.status = 0
		temp.num = i		#used as exp_num for now....
		i = i+1
	end
	@paper.status = 0
    respond_to do |format|
      if @paper.save
		#Emailer.entry_received(current_user.email, @entry).deliver
		#Emailer.admin_entry_added("cstinson@vt.edu", @entry).deliver
		#@authors = Author.all
        format.html { redirect_to paper_authors_path(@paper), :notice => 'Paper was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
	#params[:paper][:author_ids] ||= []
	#params[:paper][:author_ids].collect{|s| s.to_i}

    respond_to do |format|
      if @paper.update_attributes(params[:paper])
		#Emailer.entry_updated(current_user.email, @entry).deliver
		#Emailer.admin_entry_updated("cstinson@vt.edu", @entry).deliver
        format.html { redirect_to @paper, :notice => 'Paper was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  

  def destroy
    @paper.destroy
	if current_user.admin
		redirect_to admin_path, :notice => 'Entry was successfully deleted.'
	else
		redirect_to root_path, :notice => 'Entry was successfully deleted.'
	end
  end

  
  def confirm_authors
    @paper = Paper.find(params[:paper_id])
	params[:paper][:author_ids] ||= []
	@paper.update_attributes(params[:paper])
	redirect_to paper_experiments_path(@paper), :notice => 'Authors were successfully added.'
  end
  
end
