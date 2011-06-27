class TasksController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  def create
	@task = Task.create(params[:task])
	@task.save
	redirect_to admin_path, :notice => 'Task added successfully.'
  end

  def destroy
	@task = Task.find(params[:id])
    @task.destroy
	redirect_to admin_path, :notice => 'Task deleted successfully.'
  end
  
end
