class CompsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  def create
	@comp = Comp.create(params[:comp])
	@comp.save
	redirect_to admin_path, :notice => 'Component added successfully.'
  end

  def destroy
	@comp = Comp.find(params[:id])
    @comp.destroy
	redirect_to admin_path, :notice => 'Component deleted successfully.'
  end
  
end
