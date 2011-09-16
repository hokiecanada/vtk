class AuthorPapersController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? && !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  
  def create
	ap = AuthorPaper.create(params[:author_paper])
	if !params[:last_name].nil?
		author = Author.create(:last_name => params[:last_name], :first_name => params[:first_name], :initials => params[:initials])
		if author.initials.nil?
			author.initials = ""
			author.save
		end
		ap.author_id = author.id
		ap.save
	end
	redirect_to paper_authors_path(ap.paper_id), :notice => 'Author added successfully.'
  end

  
  def update
	#Author.find(params[:id]).update_attributes(params[:author])
	#redirect_to admin_path, :notice => 'Author successfully updated.'
  end
  
  
  def destroy
	ap = AuthorPaper.find(params[:id])
    ap.destroy
	##maybe check to see if all records for a specific author are gone
	##and if so delete the author too
	redirect_to paper_authors_path(ap.paper_id), :notice => 'Author deleted successfully.'
  end
  
end
