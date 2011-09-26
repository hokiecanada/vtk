class ExperimentsController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :edit, :update, :destroy, :type, :num_findings, :new]
  before_filter :authenticate_role, 			:only => [:index, :edit, :update, :destroy, :type, :num_findings, :new]
  
  def authenticate_role
	@paper = Paper.find(params[:paper_id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@experiments = @paper.experiments.all
	if @paper.status == 2
		complete = true
		if @experiments.size == 0
			complete = false
		end
		@experiments.each do |e|
			if e.status != 0
				complete = false
			end
		end
	end
	if complete == true
		@paper.status = 0
		@paper.save
	end
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.save
  end

  
  def new
	@experiment = @paper.experiments.build
	@experiment.exp_type = 0
	@experiment.status = 1
	@experiment.num_views = 0
	@experiment.num = @paper.experiments.size
	@experiment.save
	@paper.status = 2
	@paper.save
	redirect_to paper_experiments_path(@paper), :notice => 'Experiment was successfully added.'
  end

  
  def edit
    @experiment = @paper.experiments.find(params[:id])
	@tasks = Task.all
	@comps = Comp.all
	@systems = System.all
	@metrics = Metric.all
  end

  
  def update
	@experiment = @paper.experiments.find(params[:id])
	params[:experiment][:system_ids] ||= []
	params[:experiment][:comp_ids] ||= []
	params[:experiment][:metric_ids] ||= []
	params[:experiment][:task_ids] ||= []

	if @experiment.update_attributes(params[:experiment])
		@experiment.findings.each do |finding|
			finding.tasks = @experiment.tasks
			if @experiment.exp_type == 0
				finding.systems = @experiment.systems
				#adjust comps & metrics somehow... maybe change status of affected findings??
			else
				finding.comps = @experiment.comps
			end
			finding.save
		end
		@experiment.title = @experiment.paper.authors.first.last_name + " et al, " + @experiment.paper.year.strftime("%Y") + ", Experiment #" + @experiment.num.to_s
		@experiment.save

		if @experiment.status == 1
			@experiment.status = 2
			@experiment.save
			redirect_to num_findings_path(:paper_id => @paper, :id => @experiment), :notice => 'Experiment details were successfully added.'
		elsif @experiment.status == 2
			redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Experiment details were successfully updated.'
		else
			redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Experiment details were successfully updated. Now please ensure that the findings for this experiment coincide with the updates you just made.'
		end
	else
        render :action => "edit"
    end
  end
  

  def destroy
    @experiment = @paper.experiments.find(params[:id])
	@paper.experiments.each do |exp|
		if exp.num > @experiment.num
			exp.num = exp.num - 1
			exp.title = exp.paper.authors.first.last_name + " et al, " + exp.paper.year.strftime("%Y") + ", Experiment #" + exp.num.to_s
			exp.save
		end
	end
	@experiment.destroy
	if current_user.admin && @paper.status == 0
		redirect_to user_root_path, :notice => 'Experiment was successfully deleted.'
	else
		redirect_to paper_experiments_path(@paper), :notice => 'Experiment was successfully deleted.'
	end
  end
  
  
  def type
	@experiment = @paper.experiments.find(params[:id])
	if !params[:exp_type].nil?
		@experiment.exp_type = params[:exp_type].to_i
		@experiment.status = 1
		@experiment.save
		redirect_to edit_paper_experiment_path(@experiment.paper_id,@experiment)
	end
  end
  
  
  def num_findings
	@experiment = @paper.experiments.find(params[:id])
	if @experiment.findings.size != 0
		redirect_to paper_experiment_findings_path(@experiment.paper_id,@experiment), :notice => 'If you wish to change the number of findings, please do so by adding/deleting individual records from the list below.'
	end
	if !params[:num_findings].nil?
		1.upto(params[:num_findings].to_i) do
			temp = @experiment.findings.build
			temp.status = 1
			temp.num_views = 0
			temp.save
		end
		redirect_to paper_experiment_findings_path(@paper,@experiment)
	end
  end
  
end
	#if @paper.status != 0
		#	complete = true
		##		if exp.status != 0
		#			complete = false
		#		end
		#	end
		#	if complete == true
		#		@paper.status = 0
		#		@paper.save
		#	end
		#end
	    #if @paper.status != 0
		#	redirect_to paper_experiment_findings_path(@paper,@experiment), :notice => 'Experiment details were successfully added.'
		#else
		#	redirect_to @paper, :notice => 'Experiment details were successfully updated.'
		#end