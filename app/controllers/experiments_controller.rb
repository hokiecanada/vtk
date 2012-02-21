class ExperimentsController < ApplicationController

  before_filter :authenticate_user!, 			:only => [:index, :edit, :create, :update, :destroy, :type, :num_findings, :controlled, :practical]
  before_filter :authenticate_role, 			:only => [:index, :edit, :create, :update, :destroy, :type, :num_findings, :controlled, :practical]
  
  def authenticate_role
	@paper = Paper.find(params[:paper_id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@experiments = @paper.experiments
	if !params[:title].nil?
		flash[:notice] = 'The details for EXPERIMENT "' + params[:title] + '" are now complete. If there is another experiment to add to this entry do so now. Otherwise click the button below to move to the review stage.'
	else
		flash[:notice] = 'Here you can add another experiment, or browse already enterred info. Or submit if you are done.'
	end
	#if @paper.status == 2
	#	complete = true
	#	if @experiments.size == 0
	#		complete = false
	#	end
	#	@experiments.each do |e|
	#		if e.status != 0
	#			complete = false
	#		end
	#	end
	#end
	#if complete == true
	#	@paper.status = 0
	#	@paper.save
	#end
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.save
  end

  
  def edit
    @experiment = @paper.experiments.find(params[:id])
	@comps = Comp.all
	@systems = System.all
	flash[:notice] = 'Here you can edit the basic details for the experiment.'
  end


  def create
	params[:experiment][:system_ids] ||= []
	params[:experiment][:comp_ids] ||= []
	
	#@experiment.num = @paper.experiments.count
	#@experiment.title = @experiment.paper.authors.first.last_name + " et al, " + @experiment.paper.year.strftime("%Y") + ", Experiment #" + @experiment.num.to_s
	#@experiment.num_views = 0
	#@experiment.status = 0
		
	if @experiment = @paper.experiments.create(params[:experiment])
		#@experiment.num = @paper.experiments.count
		#@experiment.title = @experiment.paper.authors.first.last_name + " et al, " + @experiment.paper.year.strftime("%Y") + ", Experiment #" + @experiment.num.to_s
		@experiment.num_views = 0
		@experiment.status = 0
		@experiment.save
		redirect_to new_paper_experiment_exp_task_path(@paper,@experiment), :notice => 'The basic experiment details were added successfully. Now it is time to describe the different user tasks involved in the experiment. Most experiments will only have one user task {more}. For each user task you will begin my providing the basic details, and then add relevent findings.'
	else
        render :action => "edit"
    end
  end

  
  def update
	@experiment = @paper.experiments.find(params[:id])
	params[:experiment][:system_ids] ||= []
	params[:experiment][:comp_ids] ||= []

	if @experiment.update_attributes(params[:experiment])
		#@experiment.title = @experiment.paper.authors.first.last_name + " et al, " + @experiment.paper.year.strftime("%Y") + ", Experiment #" + @experiment.num.to_s
		#@experiment.save
		#if @experiment.exp_tasks.size > 0
		##	redirect_to paper_experiment_exp_tasks_path(@paper,@experiment), :notice => 'Experiment details were successfully updated.'
		redirect_to paper_experiments_path(@paper), :notice => 'The experiment details were successfully updated. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
		#else
		#	redirect_to new_paper_experiment_exp_task_path(@paper,@experiment), :notice => 'Experiment details were successfully updated.'
		#end
	else
        render :action => "edit"
    end
  end
  

  def destroy
    @experiment = @paper.experiments.find(params[:id])
	@experiment.destroy
	#if current_user.admin #&& @paper.status == 0
	#	redirect_to user_root_path, :notice => 'Experiment was successfully deleted.'
	#else
	redirect_to paper_experiments_path(@paper), :notice => 'The experiment was successfully deleted. If you are finished adding details for this entry you can click the button below to proceed to the review stage. Otherwise continue adding/editing details.'
	#end
  end
  
  def controlled
	@experiment = @paper.experiments.build
	@comps = Comp.all
	@systems = System.all
	flash[:notice] = 'Here you will add details about the CONTROLLED experiment. After adding the basic details in this form you will be asked to provide the user tasks and findings for this experiment.'
  end
  
  def practical
  	@experiment = @paper.experiments.build
	@comps = Comp.all
	@systems = System.all
	flash[:notice] = 'Here you will add details about the PRACTICAL experiment. After adding the basic details in this form you will be asked to provide the user tasks and findings for this experiment.'
  end
  
end