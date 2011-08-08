class BrowseController < ApplicationController

  def index
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	@authors = Author.all
	respond_to do |format|
		format.html # index.html.erb
	end
  end
  
  def browse_task
	@task = Task.find(params[:task])
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	
	if params[:filter_comps].nil?
		@filter_comps = @comps.map(&:id)
	else
		@filter_comps = params[:filter_comps].map(&:to_i)
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics.map(&:id)
	else
		@filter_metrics = params[:filter_metrics].map(&:to_i)
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems.map(&:id)
	else
		@filter_systems = params[:filter_systems].map(&:to_i)
	end
	if params[:display_as].nil?
		@display_as = "Findings"
	else
		@display_as = params[:display_as]
	end
	
	@findings = Finding.joins(:tasks).where(:tasks => {:id => @task}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.joins(:tasks).where(:tasks => {:id => @task}) & Experiment.joins(:comps).where(:comps => {:id => @filter_comps}) & Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Experiment.joins(:systems).where(:systems => {:id => @filter_systems})
	@papers = 	Paper.where(:id => @experiments.collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:comps).where(:comps => {:id => @filter_comps}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:systems).where(:systems => {:id => @filter_systems}).collect{|x| x.paper_id})

	respond_to do |format|
	  format.html # browse_task.html.erb
	end
  end
 
  def browse_comp
	@comp = Comp.find(params[:comp])
	@tasks = Task.all
	@metrics = Metric.all
	@systems = System.all
	
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks.map(&:id)
	else
		@filter_tasks = params[:filter_tasks].map(&:to_i)
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics.map(&:id)
	else
		@filter_metrics = params[:filter_metrics].map(&:to_i)
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems.map(&:id)
	else
		@filter_systems = params[:filter_systems].map(&:to_i)
	end
	if params[:display_as].nil?
		@display_as = "Findings"
	else
		@display_as = params[:display_as]
	end
	
	@findings = Finding.joins(:comps).where(:comps => {:id => @comp}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.joins(:comps).where(:comps => {:id => @comp}) & Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Experiment.joins(:systems).where(:systems => {:id => @filter_systems})
	@papers = 	Paper.where(:id => @experiments.collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:systems).where(:systems => {:id => @filter_systems}).collect{|x| x.paper_id})
	
	respond_to do |format|
	  format.html # browse_comp.html.erb
	end
  end

  def browse_metric
	@metric = Metric.find(params[:metric])
	@tasks = Task.all
	@comps = Comp.all
	@systems = System.all
	
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks.map(&:id)
	else
		@filter_tasks = params[:filter_tasks].map(&:to_i)
	end
	if params[:filter_comps].nil?
		@filter_comps = @comps.map(&:id)
	else
		@filter_comps = params[:filter_comps].map(&:to_i)
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems.map(&:id)
	else
		@filter_systems = params[:filter_systems].map(&:to_i)
	end
	if params[:display_as].nil?
		@display_as = "Findings"
	else
		@display_as = params[:display_as]
	end
	
	@findings = Finding.joins(:metrics).where(:metrics => {:id => @metric}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.joins(:metrics).where(:metrics => {:id => @metric}) & Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Experiment.joins(:comps).where(:comps => {:id => @filter_comps}) & Experiment.joins(:systems).where(:systems => {:id => @filter_systems})
	@papers = 	Paper.where(:id => @experiments.collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:comps).where(:comps => {:id => @filter_comps}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:systems).where(:systems => {:id => @filter_systems}).collect{|x| x.paper_id})

	respond_to do |format|
	  format.html # browse_metric.html.erb
	end
  end

  def browse_system
	@system = System.find(params[:system])
	@tasks = Task.all
	@metrics = Metric.all
	@comps = Comp.all
	
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks.map(&:id)
	else
		@filter_tasks = params[:filter_tasks].map(&:to_i)
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics.map(&:id)
	else
		@filter_metrics = params[:filter_metrics].map(&:to_i)
	end
	if params[:filter_comps].nil?
		@filter_comps = @comps.map(&:id)
	else
		@filter_comps = params[:filter_comps].map(&:to_i)
	end
	if params[:display_as].nil?
		@display_as = "Findings"
	else
		@display_as = params[:display_as]
	end
	
	@findings = Finding.joins(:systems).where(:systems => {:id => @system}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps})
	@experiments = Experiment.joins(:systems).where(:systems => {:id => @system}) & Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Experiment.joins(:comps).where(:comps => {:id => @filter_comps})
	@papers = 	Paper.where(:id => @experiments.collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:tasks).where(:tasks => {:id => @filter_tasks}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:metrics).where(:metrics => {:id => @filter_metrics}).collect{|x| x.paper_id}) & Paper.where(:id => Experiment.joins(:comps).where(:comps => {:id => @filter_comps}).collect{|x| x.paper_id})

	respond_to do |format|
	  format.html # browse_system.html.erb
	end
  end  
end