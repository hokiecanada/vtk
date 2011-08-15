class SearchController < ApplicationController
	helper_method :sort_column, :sort_direction

  def index
    @tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  
  def search_comps
	@search_comp = params[:search_comp]
	@comp = Comp.find(params[:search_comp].to_i())
	@tasks = Task.all
	#@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all

	if params[:filter_tasks].nil? || params[:filter_tasks] == [""]
		f_tasks = @tasks
		@filter_tasks = nil
	else
		f_tasks = Task.where(:id => params[:filter_tasks])
		@filter_tasks = params[:filter_tasks]
	end
	if params[:filter_metrics].nil? || params[:filter_metrics] == [""]
		f_metrics = @metrics
		@filter_metrics = nil
	else
		f_metrics = Metric.where(:id => params[:filter_metrics])
		@filter_metrics = params[:filter_metrics]
	end
	if params[:filter_systems].nil? || params[:filter_systems] == [""]
		f_systems = @systems
		@filter_systems = nil
	else
		f_systems = System.where(:id => params[:filter_systems])
		@filter_systems = params[:filter_systems]
	end
	
	if !params[:display_as].nil?
		@display_as = params[:display_as]
	else
		@display_as = "Findings"
	end
	
	if @display_as == "Findings"
		@findings = Finding.joins(:comps).where(:comps => {:id => @search_comp}).merge(Finding.joins(:tasks).where(:tasks => {:id => f_tasks}).merge(Finding.joins(:metrics).where(:metrics => {:id => f_metrics}).merge(Finding.joins(:systems).where(:systems => {:id => f_systems}))))
		if params[:sort] == "relationship"
			@findings = @findings.joins(:relationships).order("rel_tag " + sort_direction)
		else
			@findings = @findings.order(sort_column(@display_as) + " " + sort_direction)
		end
		#@findings_ranks = @findings.map{|x| [x, x.tasks.where(:tasks => {:id => @filter_tasks}).count()+x.metrics.where(:metrics => {:id => @filter_metrics}).count()+x.systems.where(:systems => {:id => @filter_systems}).count()]}
	elsif @display_as == "Experiments"
		@experiments = Experiment.joins(:comps).where(:comps => {:id => @search_comp}).merge(Experiment.joins(:tasks).where(:tasks => {:id => f_tasks}).merge(Experiment.joins(:metrics).where(:metrics => {:id => f_metrics}).merge(Experiment.joins(:systems).where(:systems => {:id => f_systems}))))
		@experiments = @experiments.order(sort_column(@display_as) + " " + sort_direction)
		#@experiments_ranks = @experiments.map{|x| [x, x.tasks.where(:tasks => {:id => @filter_tasks}).count()+x.metrics.where(:metrics => {:id => @filter_metrics}).count()+x.systems.where(:systems => {:id => @filter_systems}).count()]}
	else
		experiments = Experiment.joins(:comps).where(:comps => {:id => @search_comp}).merge(Experiment.joins(:tasks).where(:tasks => {:id => f_tasks}).merge(Experiment.joins(:metrics).where(:metrics => {:id => f_metrics}).merge(Experiment.joins(:systems).where(:systems => {:id => f_systems}))))
		@papers = Paper.where(:id => experiments.map{|x| x.paper_id})
		if params[:sort] == "authors"
			@papers = @papers.joins(:authors).first.order("last_name " + sort_direction)
		else
			@papers = @papers.order(sort_column(@display_as) + " " + sort_direction)
		end
		#@papers_ranks = @papers.map{|x| [x, Task.where(:id => @filter_tasks).joins(:experiments).where(:experiments => {:id => x.experiments}).count()+Metric.where(:id => @filter_metrics).joins(:experiments).where(:experiments => {:id => x.experiments}).count()+System.where(:id => @filter_systems).joins(:experiments).where(:experiments => {:id => x.experiments}).count()]}
	end

	respond_to do |format|
	  format.html # search_comps.html.erb
	end
  end
  
  
  def search_tasks
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_comps].nil? || params[:filter_comps] == [""]
		f_comps = @comps
		@filter_comps = nil
	else
		f_comps = Comp.where(:id => params[:filter_comps])
		@filter_comps = f_comps
	end
	if params[:filter_metrics].nil? || params[:filter_metrics] == [""]
		f_metrics = @metrics
		@filter_metrics = nil
	else
		f_metrics = Metric.where(:id => params[:filter_metrics])
		@filter_metrics = f_metrics
	end
	if params[:filter_systems].nil? || params[:filter_systems] == [""]
		f_systems = @systems
		@filter_systems = nil
	else
		f_systems = System.where(:id => params[:filter_systems])
		@filter_systems = f_systems
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:task_display_as].nil?
		@display_as = params[:task_display_as]
	else
		@display_as = "Findings"
	end
	@search_task = params[:search_task]
	@task = Task.find(params[:search_task])
	@findings = Finding.joins(:tasks).where(:tasks => {:id => @search_task}) & Finding.joins(:comps).where(:comps => {:id => f_comps}) & Finding.joins(:metrics).where(:metrics => {:id => f_metrics}) & Finding.joins(:systems).where(:systems => {:id => f_systems})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_tasks.html.erb
	end
  end
  
  
  def search_metrics
	@tasks = Task.all
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	if params[:filter_comps].nil? || params[:filter_comps] == [""]
		f_comps = @comps
		@filter_comps = nil
	else
		f_comps = Comp.where(:id => params[:filter_comps])
		@filter_comps = f_comps
	end
	if params[:filter_tasks].nil? || params[:filter_tasks] == [""]
		f_tasks = @tasks
		@filter_tasks = nil
	else
		f_tasks = Task.where(:id => params[:filter_tasks])
		@filter_tasks = f_tasks
	end
	if params[:filter_systems].nil? || params[:filter_systems] == [""]
		f_systems = @systems
		@filter_systems = nil
	else
		f_systems = System.where(:id => params[:filter_systems])
		@filter_systems = f_systems
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:metric_display_as].nil?
		@display_as = params[:metric_display_as]
	else
		@display_as = "Findings"
	end
	@search_metric = params[:search_metric]
	@metric = Metric.find(params[:search_metric])
	@findings = Finding.joins(:metrics).where(:metrics => {:id => @search_metric}) & Finding.joins(:comps).where(:comps => {:id => f_comps}) & Finding.joins(:tasks).where(:tasks => {:id => f_tasks}) & Finding.joins(:systems).where(:systems => {:id => f_systems})
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
	if params[:filter_comps].nil? || params[:filter_comps] == [""]
		f_comps = @comps
		@filter_comps = nil
	else
		f_comps = Comp.where(:id => params[:filter_comps])
		@filter_comps = f_comps
	end
	if params[:filter_metrics].nil? || params[:filter_metrics] == [""]
		f_metrics = @metrics
		@filter_metrics = nil
	else
		f_metrics = Metric.where(:id => params[:filter_metrics])
		@filter_metrics = f_metrics
	end
	if params[:filter_tasks].nil? || params[:filter_tasks] == [""]
		f_tasks = @tasks
		@filter_tasks = nil
	else
		f_tasks = Task.where(:id => params[:filter_tasks])
		@filter_tasks = f_tasks
	end
	if !params[:filter_display_as].nil?
		@display_as = params[:filter_display_as]
	elsif !params[:system_display_as].nil?
		@display_as = params[:system_display_as]
	else
		@display_as = "Findings"
	end
	@search_system = params[:search_system]
	@system = System.find(params[:search_system])
	@findings = Finding.joins(:systems).where(:systems => {:id => @search_system}) & Finding.joins(:comps).where(:comps => {:id => f_comps}) & Finding.joins(:metrics).where(:metrics => {:id => f_metrics}) & Finding.joins(:tasks).where(:tasks => {:id => f_tasks})
	@experiments = Experiment.where(:id => @findings.map{|x| x.experiment_id})
	@papers = Paper.where(:id => @experiments.map{|x| x.paper_id})

	respond_to do |format|
	  format.html # search_systems.html.erb
	end
  end
  
  private
  
  def sort_column(display_as)
    if display_as == "Findings"
		%w[finding specificity relationship].include?(params[:sort]) ? params[:sort] : "finding"
	elsif display_as == "Experiments"
		%w[title exp_type env_scale env_realism part_num].include?(params[:sort]) ? params[:sort] : "title"
	else
		%w[title year authors].include?(params[:sort]) ? params[:sort] : "title"
	end
  end
  
  def sort_direction
    params[:direction] || "asc"
	#%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end