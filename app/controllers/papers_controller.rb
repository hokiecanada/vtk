class PapersController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:new, :create, :edit, :update, :destroy]
  before_filter :authenticate_role, 			:only => [:edit, :update, :destroy]
  
  def authenticate_role
	#@user = User.find(current_user)
	@paper = current_user.papers.find(params[:id])
		
	if @paper.user_id != current_user.id # or is an admin...
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
	@paper.update_attributes(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
  def new
	@paper = current_user.papers.build
	@paper.authors.build
	respond_to do |format|
		format.html # new.html.erb
	end
  end

  
  def edit
  end

  
  def create
    @paper = current_user.papers.create(params[:paper])
	@paper.num_views = 0
	@paper.status = "Pending"
    respond_to do |format|
      if @paper.save
		#Emailer.entry_received(current_user.email, @entry).deliver
		#Emailer.admin_entry_added("cstinson@vt.edu", @entry).deliver
        format.html { redirect_to @paper, :notice => 'Paper was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
	@paper.status = "Pending"
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
	respond_to do |format|
		format.html { redirect_to root_path, :notice => 'Entry was successfully deleted.' }
	end
  end
  
end
