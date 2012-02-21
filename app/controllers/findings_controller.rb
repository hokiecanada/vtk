class FindingsController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_role, 			:only => [:index, :new, :edit, :create, :update, :destroy]
  
  def authenticate_role
	@paper = Paper.find(params[:paper_id])
	@experiment = @paper.experiments.find(params[:experiment_id])
	@exp_task = @experiment.exp_tasks.find(params[:exp_task_id])
		
	if @paper.user_id != current_user.id && !current_user.admin
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@findings = @exp_task.findings.all
	

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
	@finding = @exp_task.findings.build
	@comps = @experiment.comps.all
	@systems = @experiment.systems.all
	@metrics = @exp_task.metrics.all
	@relationships = Relationship.all
  end

  
  def edit
    @finding = @exp_task.findings.find(params[:id])
	@comps = @experiment.comps.all
	@systems = @experiment.systems.all
	@metrics = @exp_task.metrics.all
	@relationships = Relationship.all
  end

  
  def create
	@finding = @exp_task.findings.create(params[:finding])
	@finding.tasks = @exp_task.tasks
	
	if @experiment.exp_type == 0
		@finding.systems = @experiment.systems
	else
		@finding.comps = @experiment.comps
	end
	
	@finding.num_views = 0
	
    if @finding.save
        redirect_to new_paper_experiment_exp_task_finding_path(@paper,@experiment,@exp_task), :notice => 'The finding was successfully added. If you have more findings to add continue in same manner. If you are done adding findings click the button below to complete this user task.'
    else
        render :action => "edit"
    end
  end

  
  def update
	@finding = @exp_task.findings.find(params[:id])
	
	if @experiment.exp_type == 0
		params[:finding][:comp_ids] ||= []
	else
		params[:finding][:system_ids] ||= []
	end
	params[:finding][:metric_ids] ||= []
	@finding.update_attributes(params[:finding])
	
	@finding.tasks = @exp_task.tasks
	if @experiment.exp_type == 0
		@finding.systems = @experiment.systems
	else
		@finding.comps = @experiment.comps
	end
	
	if @finding.save
        #redirect_to paper_experiment_exp_task_findings_path(@paper,@experiment,@exp_task), :notice => 'Finding details were successfully updated.'
		redirect_to paper_experiments_path(@paper), :notice => 'The finding was successfully updated. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
	else
        render :action => "edit"
    end
  end
  

  def destroy
    @finding = @exp_task.findings.find(params[:id])
	@finding.destroy
	#if current_user.admin && @paper.status == 0
	#	redirect_to user_root_path, :notice => 'Finding was successfully deleted.'
	#else
	redirect_to paper_experiments_path(@paper), :notice => 'The finding was successfully deleted. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
	#end
  end

end
