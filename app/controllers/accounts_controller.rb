class AccountsController < ApplicationController

  def home
    authenticate_user!
	if current_user.admin
		redirect_to admin_path
	else
		@papers = current_user.papers
		respond_to do |format|
			format.html # home.html.erb
		end
	end
  end
  
  def admin
    if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access Denied.'
	else
		@papers = Paper.all
		@authors = Author.all
		@tasks = Task.all
		@comps = Comp.all
		@metrics = Metric.all
		@systems = System.all
		@relationships = Relationship.all
		@users = User.all
		
		respond_to do |format|
		  format.html # admin.html.erb
		end
	end
  end
  
end
