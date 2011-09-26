class PapersController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:new, :create, :edit, :update, :destroy, :confirm_authors, :num_experiments]
  before_filter :authenticate_role, 			:only => [:edit, :update, :destroy, :confirm_authors, :num_experiments]
  
  def authenticate_role
	@paper = Paper.find(params[:id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@papers = Paper.all
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.save
	@experiments = @paper.experiments.all
  end

  
  def new
	@paper = current_user.papers.build
  end

  def edit
    @authors = Author.all
  end

  
  def create
    @paper = current_user.papers.create(params[:paper])
	@paper.num_views = 0
	@paper.status = 1
    if @paper.save
		redirect_to paper_authors_path(@paper), :notice => 'Paper was successfully added.'
    else
        render :action => "new"
    end
  end


  def update
    if @paper.update_attributes(params[:paper])
		redirect_to @paper, :notice => 'Paper was successfully updated.'
    else
        render :action => "edit"
    end
  end
  

  def destroy
    authors = Author.where(:id => @paper.authors)
	@paper.destroy
	authors.each do |a|
		if a.papers.size == 0
			a.destroy
		end
	end
	
	if current_user.admin
		redirect_to admin_path, :notice => 'Entry was successfully deleted.'
	else
		redirect_to root_path, :notice => 'Entry was successfully deleted.'
	end
  end

  
  def confirm_authors
	if @paper.authors.size > 0
		if (@paper.status == 1)
			@paper.status = 2
			@paper.save
			redirect_to num_experiments_path(:id => @paper), :notice => 'Authors were successfully added.'
		else
			redirect_to @paper, :notice => 'Authors were successfully updated.'
		end
	else
		redirect_to paper_authors_path(@paper), :notice => 'There must be at least 1 author associated with the entry.'
	end
  end

  def num_experiments
	if @paper.experiments.size != 0
		redirect_to paper_experiments_path(@paper), :notice => 'If you wish to change the number of experiments, please do so by adding/deleting individual records from the list below.'
	elsif !params[:num_exps].nil?
		i=1
		1.upto(params[:num_exps].to_i) do
			temp = @paper.experiments.build
			temp.exp_type = 0
			temp.status = 1
			temp.num_views = 0
			temp.num = i
			i = i+1
			temp.save
		end
		redirect_to paper_experiments_path(@paper.id)
	end
  end
  
end
