class SystemsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  def create
	@system = System.create(params[:system])
	@system.save
	redirect_to admin_path, :notice => 'System added successfully.'
  end

  def destroy
	@system = System.find(params[:id])
    @system.destroy
	redirect_to admin_path, :notice => 'System deleted successfully.'
  end
  
end
