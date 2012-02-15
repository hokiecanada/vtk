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
	redirect_to edit_paper_path(:id => ap.paper_id), :notice => 'Author added successfully.'
	#redirect_to add_authors_path(:id => ap.paper_id), :notice => 'Author added successfully.'
  end

  
  def destroy
	ap = AuthorPaper.find(params[:id])
	author = Author.find(ap.author_id)
	author_papers = Paper.find(ap.paper_id).author_papers
	order = ap.order
	
    ap.destroy
	
	if author.papers.size == 0
		author.destroy
	end
	
	author_papers.each do |a|
		if a.order > order
			a.order = a.order - 1
			a.save
		end
	end
	
	redirect_to edit_paper_path(ap.paper_id), :notice => 'Author deleted successfully.'
	#redirect_to add_authors_path(ap.paper_id), :notice => 'Author deleted successfully.'
  end
  
end
