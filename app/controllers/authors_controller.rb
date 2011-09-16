class AuthorsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? && !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  
  def index
	@paper = Paper.find(params[:paper_id])
	@paper_authors = @paper.author_papers.where(:paper_id => @paper)
	@paper_author = @paper.author_papers.build
	@authors = Author.all
  end
  
  
  def edit
	@author = Author.find(params[:id])
  end
  
  
  def create
	@paper = Paper.find(params[:paper_id])
	author = @paper.authors.create(params[:author])
	if author.initials.nil?
		author.initials = ""
		author.save
	end
	redirect_to paper_authors_path(@paper), :notice => 'Author added successfully.'
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
