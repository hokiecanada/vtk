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
	@finding = @experiment.findings.find(params[:id])
	@finding.num_views += 1
	@finding.update_attributes(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
  def new
	@finding = @experiment.findings.build
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	
	respond_to do |format|
		format.html # new.html.erb
	end
  end

  
  def edit
    @finding = @experiment.findings.find(params[:id])
	@comps = Comp.all
	@systems = System.all
	@metrics = Metric.all
	
	respond_to do |format|
		format.html # edit.html.erb
	end
  end

  
  def create
	@finding = @experiment.findings.create(params[:finding])
	@finding.status = 1
	
    respond_to do |format|
      if @finding.save
        format.html { redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Finding was successfully added.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  
  def update
	@finding = @experiment.find(params[:id])
	params[:finding][:system_ids] ||= []
	params[:finding][:comp_ids] ||= []
	params[:finding][:metric_ids] ||= []
	params[:finding][:task_ids] ||= []
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
    @experiment = @paper.experiments.find(params[:id])
	@experiment.destroy
	respond_to do |format|
		format.html { redirect_to paper_experiments_path(@paper), :notice => 'Experiment was successfully deleted.' }
	end
  end
  
end
