class AuthorsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? && !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  
  def index
	@paper = Paper.find(params[:paper_id])
	@paper_authors = @paper.author_papers.all
	@paper_author = @paper.author_papers.build
	@authors = Author.all
  end
  
  
  def edit
	@author = Author.find(params[:id])
  end
  
  
  def create
	@paper = Paper.find(params[:paper_id])
	@author = Author.create(params[:author])
	
	if @author.save
		AuthorPaper.create(:paper_id => @paper.id, :author_id => @author.id, :order => params[:order])
		#author = @paper.authors.create(params[:author])
		if @author.initials.nil?
			@author.initials = ""
			@author.save
		end
		redirect_to edit_paper_path(@paper), :notice => 'Author added successfully.'
	else
		@paper_authors = @paper.author_papers.all
		@paper_author = @paper.author_papers.build
		@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
		@authors = @authors.sort_by(&:last_name)
		render :template => "papers/edit"
	end
  end

  
  def update
	Author.find(params[:id]).update_attributes(params[:author])
	redirect_to admin_path, :notice => 'Author successfully updated.'
  end
  
  
  def destroy
	@author = Author.find(params[:id])
    @author.destroy
	redirect_to admin_path, :notice => 'Author deleted successfully.'
  end
  
end
