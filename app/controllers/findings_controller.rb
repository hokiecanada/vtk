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
	if @experiment.status == 2
		complete = true
		if @findings.size == 0
			complete = false
		end
		@findings.each do |f|
			if f.status != 0
				complete = false
			end
		end
	end
	if complete == true
		@experiment.status = 0
		@experiment.save
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
	@finding.status = 1
	@finding.num_views = 0
	@finding.save
	@experiment.status = 2
	@experiment.save
	@paper.status = 2
	@paper.save
	redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding was successfully added.'
  end

  
  def edit
    @finding = @experiment.findings.find(params[:id])
	@tasks = @experiment.tasks.all
	@comps = @experiment.comps.all
	@metrics = @experiment.metrics.all
	@systems = @experiment.systems.all
	@relationships = Relationship.all
  end

  
  def create
	@finding = @experiment.findings.create(params[:finding])
	#@finding.tasks = Experiment.find(@finding.experiment_id).tasks
	@finding.tasks = @experiment.tasks
	
	if @experiment.exp_type == 0
		#@finding.systems = Experiment.find(@finding.experiment_id).systems
		@finding.systems = @experiment.systems
	else
		#@finding.comps = Experiment.find(@finding.experiment_id).comps
		@finding.comps = @experiment.comps
	end
	
	@finding.status = 0
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
	@finding.tasks = @experiment.tasks
	if @experiment.exp_type == 0
		params[:finding][:comp_ids] ||= []
		@finding.systems = @experiment.systems
	else
		params[:finding][:system_ids] ||= []
		@finding.comps = @experiment.comps
	end
	params[:finding][:metric_ids] ||= []
	@finding.save
	
    if @finding.update_attributes(params[:finding])
		@finding.status = 0
		@finding.save
        redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding details were successfully updated.'
    else
        render :action => "edit"
    end
  end
  

  def destroy
    @finding = @experiment.findings.find(params[:id])
	@finding.destroy
	if current_user.admin && @paper.status == 0
		redirect_to user_root_path, :notice => 'Finding was successfully deleted.'
	else
		redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding was successfully deleted.'
	end
  end

end
