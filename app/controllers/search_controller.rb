class SearchController < ApplicationController

  def index
    @tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  
  def search_tasks
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_comps].nil?
		@filter_comps = @comps
	else
		@filter_comps = Comp.where(:id => params[:filter_comps])
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics
	else
		@filter_metrics = Metric.where(:id => params[:filter_metrics])
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems
	else
		@filter_systems = System.where(:id => params[:filter_systems])
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:task_display_as].nil?
		@display_as = params[:task_display_as]
	else
		@display_as = "Findings"
	end
	@search_tasks = params[:search_tasks]
	@findings = Finding.joins(:tasks).where(:tasks => {:id => @search_tasks}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end
  
  
  def search_comps
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks
	else
		@filter_tasks = Task.where(:id => params[:filter_tasks])
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics
	else
		@filter_metrics = Metric.where(:id => params[:filter_metrics])
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems
	else
		@filter_systems = System.where(:id => params[:filter_systems])
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:comp_display_as].nil?
		@display_as = params[:comp_display_as]
	else
		@display_as = "Findings"
	end
	@search_comps = params[:search_comps]
	@findings = Finding.joins(:comps).where(:comps => {:id => @search_comps}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_comps.html.erb
	end
  end
  
  
  def search_metrics
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_comps].nil?
		@filter_comps = @comps
	else
		@filter_comps = Comp.where(:id => params[:filter_comps])
	end
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks
	else
		@filter_tasks = Task.where(:id => params[:filter_tasks])
	end
	if params[:filter_systems].nil?
		@filter_systems = @systems
	else
		@filter_systems = System.where(:id => params[:filter_systems])
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:metric_display_as].nil?
		@display_as = params[:metric_display_as]
	else
		@display_as = "Findings"
	end
	@search_metrics = params[:search_metrics]
	@findings = Finding.joins(:metrics).where(:metrics => {:id => @search_metrics}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks}) & Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_metrics.html.erb
	end
  end

  
  def search_systems
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_comps].nil?
		@filter_comps = @comps
	else
		@filter_comps = Comp.where(:id => params[:filter_comps])
	end
	if params[:filter_metrics].nil?
		@filter_metrics = @metrics
	else
		@filter_metrics = Metric.where(:id => params[:filter_metrics])
	end
	if params[:filter_tasks].nil?
		@filter_tasks = @tasks
	else
		@filter_tasks = Task.where(:id => params[:filter_tasks])
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:system_display_as].nil?
		@display_as = params[:system_display_as]
	else
		@display_as = "Findings"
	end
	@search_systems = params[:search_systems]
	@findings = Finding.joins(:systems).where(:systems => {:id => @search_systems}) & Finding.joins(:comps).where(:comps => {:id => @filter_comps}) & Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) & Finding.joins(:tasks).where(:tasks => {:id => @filter_tasks})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_systems.html.erb
	end
  end
  
end