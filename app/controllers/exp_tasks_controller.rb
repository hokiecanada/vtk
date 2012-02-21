class ExpTasksController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :new, :edit, :create, :update, :destroy, :show]
  before_filter :authenticate_role, 			:only => [:index, :new, :edit, :create, :update, :destroy, :show]
  
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
	@exp_task = @experiment.exp_tasks.find(params[:id])
  end

  
  def new
	@exp_task = @experiment.exp_tasks.build
	@tasks = Task.all
	@metrics = Metric.all
	if !params[:title].nil?
		flash[:notice] = 'The details for USER TASK "' + params[:title] + '" are now complete. If there is another user task to add to this experiment do so now. Otherwise click the button below to complete the experiment.'
	end
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
	flash[:notice] = 'Here you can edit details for the user task.'
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
        redirect_to new_paper_experiment_exp_task_finding_path(@paper,@experiment,@exp_task), :notice => 'The basic user task details were added successfully. Now it is time to describe the different findings relevant to this user task. {more}'
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
        redirect_to paper_experiments_path(@paper), :notice => 'The user task details were successfully updated. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
		#redirect_to paper_experiment_exp_task_findings_path(@paper,@experiment,@exp_task), :notice => 'User task details were successfully updated.'
    else
        render :action => "edit"
    end
  end
  

  def destroy
    @exp_task = @experiment.exp_tasks.find(params[:id])
	@exp_task.destroy
	redirect_to paper_experiments_path(@paper), :notice => 'The experiment details were successfully updated. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
  end
  
end
