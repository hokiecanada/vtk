class ExperimentsController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :edit, :update, :destroy]
  before_filter :authenticate_role, 			:only => [:index, :edit, :update, :destroy]
  
  def authenticate_role
	@paper = Paper.find(params[:paper_id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@experiments = @paper.experiments.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.update_attributes(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
  def new
	@paper = current_user.papers.build
	#@paper.authors.build
	@authors = Author.all
	respond_to do |format|
		format.html # new.html.erb
	end
  end

  
  def edit
    @experiment = @paper.experiments.find(params[:id])
	@tasks = Task.all
	@comps = Comp.all
	@systems = System.all
	@metrics = Metric.all
	
	respond_to do |format|
		format.html # edit.html.erb
	end
  end

  
  def update
	@experiment = @paper.experiments.find(params[:id])
	params[:experiment][:system_ids] ||= []
	params[:experiment][:comp_ids] ||= []
	params[:experiment][:metric_ids] ||= []
	params[:experiment][:task_ids] ||= []
	@experiment.status = 1
	
    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Experiment details were successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  

  def destroy
    @experiment = @paper.experiments.find(params[:id])
	@experiment.destroy
	respond_to do |format|
		format.html { redirect_to paper_experiments_path(@paper), :notice => 'Experiment was successfully deleted.' }
	end
  end
  
end
