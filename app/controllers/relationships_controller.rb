class RelationshipsController < ApplicationController

  before_filter :authenticate_role
  
  def authenticate_role	
	if !user_signed_in? || !current_user.admin
		redirect_to root_path, :notice => 'Access denied.'
	end
  end
  
  def edit
	@relationship = Relationship.find(params[:id])
  end
  
  def update
	@relationship = Relationship.find(params[:id])
	
	respond_to do |format|
		if @relationship.update_attributes(params[:relationship])
			format.html { redirect_to admin_path, :notice => 'Relationship details were successfully updated.' }
		else
			format.html { render :action => "edit" }
		end
    end
  end
  
  def create
	@relationship = Relationship.create(params[:relationship])
	@relationship.save
	redirect_to admin_path, :notice => 'Relationship added successfully.'
  end

  def destroy
	@relationship = Relationship.find(params[:id])
    @relationship.destroy
	redirect_to admin_path, :notice => 'Relationship deleted successfully.'
  end
  
end
