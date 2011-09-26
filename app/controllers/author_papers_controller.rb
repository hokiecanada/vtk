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

  
  def destroy
	ap = AuthorPaper.find(params[:id])
	author = Author.find(ap.author_id)
    ap.destroy
	
	if author.papers.size == 0
		author.destroy
	end

	redirect_to paper_authors_path(ap.paper_id), :notice => 'Author deleted successfully.'
  end
  
end
