class MetricsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  def create
	@metric = Metric.create(params[:metric])
	@metric.save
	redirect_to admin_path, :notice => 'Metric added successfully.'
  end

  def destroy
	@metric = Metric.find(params[:id])
    @metric.destroy
	redirect_to admin_path, :notice => 'Metric deleted successfully.'
  end
  
end
