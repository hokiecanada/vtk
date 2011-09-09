class FindingsController < ApplicationController

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
	@findings = @experiment.findings.all
    respond_to do |format|
      format.html # index.html.erb
    end
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
	@finding = @experiment.findings.build
	@tasks = @experiment.tasks.all
	@comps = @experiment.comps.all
	@metrics = @experiment.metrics.all
	@systems = @experiment.systems.all
	@relationships = Relationship.all
	
	respond_to do |format|
		format.html # new.html.erb
	end
  end

  
  def edit
    @finding = @experiment.findings.find(params[:id])
	@tasks = @experiment.tasks.all
	@comps = @experiment.comps.all
	@metrics = @experiment.metrics.all
	@systems = @experiment.systems.all
	@relationships = Relationship.all
	
	respond_to do |format|
		format.html # edit.html.erb
	end
  end

  
  def create
	@finding = @experiment.findings.create(params[:finding])
	@finding.tasks = Experiment.find(@finding.experiment_id).tasks
	@finding.status = 1
	@finding.num_views = 0
	
    respond_to do |format|
      if @finding.save
        format.html { redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding was successfully added.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  
  def update
	@finding = @experiment.findings.find(params[:id])
	params[:finding][:system_ids] ||= []
	params[:finding][:comp_ids] ||= []
	params[:finding][:metric_ids] ||= []
	#params[:finding][:task_ids] ||= []
	#@finding.tasks = Experiment.find(@finding.experiment_id).tasks
	#params[:finding][:relationship_ids] ||= []
	@finding.status = 1
	
    respond_to do |format|
      if @finding.update_attributes(params[:finding])
        format.html { redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding details were successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  

  def destroy
    @finding = @experiment.findings.find(params[:id])
	@finding.destroy
	if current_user.admin
		redirect_to user_root_path, :notice => 'Finding was successfully deleted.'
	else
		redirect_to paper_experiment_path(@experiment), :notice => 'Finding was successfully deleted.'
	end
  end

end
