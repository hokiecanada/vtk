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
		@display_as = "findings"
	else
		@display_as = params[:display_as]
	end
	@search_tasks = params[:search_tasks]
	@findings = Finding.joins(:tasks).where(:tasks => {:id => @search_tasks}) && Finding.joins(:comps).where(:comps => {:id => @filter_comps}) && Finding.joins(:metrics).where(:metrics => {:id => @filter_metrics}) && Finding.joins(:systems).where(:systems => {:id => @filter_systems})
	@experiments = Experiment.joins(:findings).where(:findings => {:id => @findings})
	@papers = Paper.joins(:experiments).where(:experiments => {:id => @experiments})

	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end
  
  
  def search_comps
    @tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	@search_comps = params[:search_comps]
	@findings = Finding.joins(:comps).where(:comps => {:id => @search_comps})
	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end
  
  
  def search_metrics
    @tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	@search_metrics = params[:search_metrics]
	@findings = Finding.joins(:metrics).where(:metrics => {:id => @search_metrics})
	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end

  
  def search_systems
    @tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	@search_systems = params[:search_systems]
	@findings = Finding.joins(:systems).where(:systems => {:id => @search_systems})
	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end
  
end