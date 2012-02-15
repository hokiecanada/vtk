class ExpTasksController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_role, 			:only => [:index, :new, :edit, :create, :update, :destroy]
  
  def authenticate_role
	@paper = Paper.find(params[:paper_id])
	@experiment = @paper.experiments.find(params[:experiment_id])
		
	if @paper.user_id != current_user.id && !current_user.admin
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@exp_tasks = @experiment.exp_tasks
  end

  
  def show
	@paper = Paper.find(params[:paper_id])
	@experiment = @paper.experiments.find(params[:experiment_id])
	@finding = @experiment.findings.find(params[:id])
	if @finding.num_views.nil?
		@finding.num_views = 1
	else
		@finding.num_views += 1
	end
	@finding.save
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
  def new
	@exp_task = @experiment.exp_tasks.build
	@tasks = Task.all
	@metrics = Metric.all
	#@experiment.status = 2
	#@experiment.save
	#@paper.status = 2
	#@paper.save
	#redirect_to paper_experiment_exp_tasks_path(@paper,@experiment), :notice => 'User task was successfully added.'
  end

  
  def edit
    @exp_task = @experiment.exp_tasks.find(params[:id])
	@tasks = Task.all
	@metrics = Metric.all
  end

  
  def create
	params[:exp_task][:task_ids] ||= []
	params[:exp_task][:metric_ids] ||= []
	
	if (@experiment.exp_tasks.count > 0) && (params[:same_as_previous] == "1")
		prev = @experiment.exp_tasks.last
		@exp_task = @experiment.exp_tasks.create(params[:exp_task])
		@exp_task.interface_desc = prev.interface_desc
		@exp_task.env_dim = prev.env_dim
		@exp_task.env_scale = prev.env_scale
		@exp_task.env_density = prev.env_density
		@exp_task.env_realism = prev.env_realism
		@exp_task.env_desc = prev.env_desc
	else
		@exp_task = @experiment.exp_tasks.create(params[:exp_task])
	end
	
    if @exp_task.save
        redirect_to new_paper_experiment_exp_task_finding_path(@paper,@experiment,@exp_task), :notice => 'User task was successfully added.'
    else
        render :action => "edit"
    end
  end

  
  def update
	@exp_task = @experiment.exp_tasks.find(params[:id])
	params[:exp_task][:task_ids] ||= []
	params[:exp_task][:metric_ids] ||= []
	#@exp_task.save
	
    if @exp_task.update_attributes(params[:exp_task])
        redirect_to paper_experiment_exp_task_findings_path(@paper,@experiment,@exp_task), :notice => 'User task details were successfully updated.'
    else
        render :action => "edit"
    end
  end
  

  def destroy
    @exp_task = @experiment.exp_tasks.find(params[:id])
	@exp_task.destroy
	if current_user.admin && @paper.status == 0
		redirect_to user_root_path, :notice => 'User task was successfully deleted.'
	else
		redirect_to paper_experiment_exp_tasks_path(@paper,@experiment), :notice => 'User task was successfully deleted.'
	end
  end
  
end
