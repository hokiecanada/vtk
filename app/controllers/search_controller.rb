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

	if (params[:filter_tasks].nil? || params[:filter_tasks] == [""]) && params[:f_tasks].nil?
		tasks = Task.all
		@f_tasks = @filter_tasks = nil
	elsif !params[:f_tasks].nil?
		tasks = @f_tasks = params[:f_tasks]
		@filter_tasks = @f_tasks.map {|x| x.id.to_s()}
	else
		tasks = @f_tasks = Task.where(:id => params[:filter_tasks])
		@filter_tasks = params[:filter_tasks]
	end
	if (params[:filter_metrics].nil? || params[:filter_metrics] == [""]) && params[:f_metrics].nil?
		metrics = Metric.all
		@f_metrics = @filter_metrics = nil
	elsif !params[:f_metrics].nil?
		metrics = @f_metrics = params[:f_metrics]
		@filter_metrics = @f_metrics.map {|x| x.id.to_s()}
	else
		metrics = @f_metrics = Metric.where(:id => params[:filter_metrics])
		@filter_metrics = params[:filter_metrics]
	end
	if (params[:filter_systems].nil? || params[:filter_systems] == [""]) && params[:f_systems].nil?
		systems = System.all
		@f_systems = @filter_systems = nil
	elsif !params[:f_systems].nil?
		systems = @f_systems = params[:f_systems]
		@filter_systems = @f_systems.map {|x| x.id.to_s()}
	else
		systems = @f_systems = System.where(:id => params[:filter_systems])
		@filter_systems = params[:filter_systems]
	end
	
	if !params[:display_as].nil?
		@display_as = params[:display_as]
	else
		@display_as = "Findings"
	end
	
	@sort = sort_column(@display_as)
	@direction = sort_direction
	
	if @display_as == "Findings"
		if @sort == "finding"
			@findings = Finding.all(:include => [:comps,:tasks,:metrics,:systems], :conditions => {"comps.id" => @comp, "tasks.id" => tasks, "systems.id" => systems, "metrics.id" => metrics}, :order => [@sort + " " + @direction])
		else
			@findings = Finding.all(:include => [:comps,:tasks,:metrics,:systems], :conditions => {"comps.id" => @comp, "tasks.id" => tasks, "systems.id" => systems, "metrics.id" => metrics})
			if @sort == "year"
				@findings = @findings.sort_by{|f| f.experiment.paper.year}
			elsif @sort == "author"
				@findings = @findings.sort_by{|f| f.experiment.paper.authors.first.last_name}
			elsif @sort == "paper"
				@findings = @findings.sort_by{|f| f.experiment.paper.title}
			end
			if @direction == "desc"
				@findings = @findings.reverse
			end
		end
		@tasks = Task.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
		@metrics = Metric.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
		@systems = System.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
	elsif @display_as == "Experiments"
		if @sort != "author"
			@experiments = Experiment.all(:include => [:comps,:tasks,:systems,:metrics], :joins => :paper, :conditions => {"comps.id" => @search_comp, "tasks.id" => tasks, "systems.id" => systems, "metrics.id" => metrics}, :order => [@sort + " " + @direction])
		else
			@experiments = Experiment.all(:include => [:comps,:tasks,:systems,:metrics], :joins => :paper, :conditions => {"comps.id" => @search_comp, "tasks.id" => tasks, "systems.id" => systems, "metrics.id" => metrics})
			@experiments = @experiments.sort_by{|f| f.paper.authors.first.last_name}
			if @direction == "desc"
				@experiments = @experiments.reverse
			end
		end
		@tasks = Task.all#(:include => [:experiments], :conditions => {"experiments.id" => @experiments})
		@metrics = Metric.all#(:include => [:experiments], :conditions => {"experiments.id" => @experiments})
		@systems = System.all#(:include => [:experiments], :conditions => {"experiments.id" => @experiments})
	else
		@experiments = Experiment.all(:include => [:comps,:tasks,:systems,:metrics], :conditions => {"comps.id" => @search_comp, "tasks.id" => tasks, "systems.id" => systems, "metrics.id" => metrics})
		ids = @experiments.map{|x| x.paper_id}
		@papers = Paper.all(:include => [:authors], :conditions => {"id" => ids}, :order => [@sort + " " + @direction])
		@tasks = Task.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
		@metrics = Metric.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
		@systems = System.all#(:include => [:findings], :conditions => {"findings.id" => @findings})
	end

	respond_to do |format|
	  format.html # search_comps.html.erb
	end
  end
  
  
  def search_tasks
	@comps = Comp.all
	@metrics = Metric.all
	@systems = System.all
	
	@search_task = params[:search_task]
	@task = Task.find(params[:search_task].to_i())

	if (params[:filter_comps].nil? || params[:filter_comps] == [""]) && params[:f_comps].nil?
		comps = Comp.all
		@f_comps = @filter_comps = nil
	elsif !params[:f_comps].nil?
		comps = @f_comps = params[:f_comps]
		@filter_comps = @f_comps.map {|x| x.id.to_s()}
	else
		comps = @f_comps = Comp.where(:id => params[:filter_comps])
		@filter_comps = params[:filter_comps]
	end
	if (params[:filter_metrics].nil? || params[:filter_metrics] == [""]) && params[:f_metrics].nil?
		metrics = Metric.all
		@f_metrics = @filter_metrics = nil
	elsif !params[:f_metrics].nil?
		metrics = @f_metrics = params[:f_metrics]
		@filter_metrics = @f_metrics.map {|x| x.id.to_s()}
	else
		metrics = @f_metrics = Metric.where(:id => params[:filter_metrics])
		@filter_metrics = params[:filter_metrics]
	end
	if (params[:filter_systems].nil? || params[:filter_systems] == [""]) && params[:f_systems].nil?
		systems = System.all
		@f_systems = @filter_systems = nil
	elsif !params[:f_systems].nil?
		systems = @f_systems = params[:f_systems]
		@filter_systems = @f_systems.map {|x| x.id.to_s()}
	else
		systems = @f_systems = System.where(:id => params[:filter_systems])
		@filter_systems = params[:filter_systems]
	end
	
	if !params[:display_as].nil?
		@display_as = params[:display_as]
	else
		@display_as = "Findings"
	end
	
	@sort = sort_column(@display_as)
	@direction = sort_direction
	
	if @display_as == "Findings"
		if @sort == "finding"
			@findings = Finding.all(:include => [:tasks,:comps,:metrics,:systems], :conditions => {"tasks.id" => @task, "comps.id" => comps, "systems.id" => systems, "metrics.id" => metrics}, :order => [@sort + " " + @direction])
		else
			@findings = Finding.all(:include => [:tasks,:comps,:metrics,:systems], :conditions => {"tasks.id" => @task, "comps.id" => comps, "systems.id" => systems, "metrics.id" => metrics})
			if @sort == "year"
				@findings = @findings.sort_by{|f| f.experiment.paper.year}
			elsif @sort == "author"
				@findings = @findings.sort_by{|f| f.experiment.paper.authors.first.last_name}
			elsif @sort == "paper"
				@findings = @findings.sort_by{|f| f.experiment.paper.title}
			end
			if @direction == "desc"
				@findings = @findings.reverse
			end
		end
	elsif @display_as == "Experiments"
		if @sort != "author"
			@experiments = Experiment.all(:include => [:tasks,:comps,:systems,:metrics], :joins => :paper, :conditions => {"tasks.id" => @search_task, "comps.id" => comps, "systems.id" => systems, "metrics.id" => metrics}, :order => [@sort + " " + @direction])
		else
			@experiments = Experiment.all(:include => [:tasks,:comps,:systems,:metrics], :joins => :paper, :conditions => {"tasks.id" => @search_task, "comps.id" => comps, "systems.id" => systems, "metrics.id" => metrics})
			@experiments = @experiments.sort_by{|f| f.paper.authors.first.last_name}
			if @direction == "desc"
				@experiments = @experiments.reverse
			end
		end
	else
		@experiments = Experiment.all(:include => [:tasks,:comps,:systems,:metrics], :conditions => {"tasks.id" => @search_task, "comps.id" => comps, "systems.id" => systems, "metrics.id" => metrics})
		ids = @experiments.map{|x| x.paper_id}
		@papers = Paper.all(:include => [:authors], :conditions => {"id" => ids}, :order => [@sort + " " + @direction])
	end

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
  
  
  def full_text_search
	@search_text = params[:search_text]
  	if !params[:display_as].nil?
		@display_as = params[:display_as]
	else
		@display_as = "Findings"
	end
	
	@sort = sort_column(@display_as)
	@direction = sort_direction
	
	if @display_as == "Findings"
		@findings = Finding.find_with_index(@search_text, {:include => [:experiment]})
		if @sort == "finding"
			@findings = @findings.sort_by{|f| f.finding}
		elsif @sort == "year"
			@findings = @findings.sort_by{|f| f.experiment.paper.year}
		elsif @sort == "author"
			@findings = @findings.sort_by{|f| f.experiment.paper.authors.first.last_name}
		elsif @sort == "paper"
			@findings = @findings.sort_by{|f| f.experiment.paper.title}
		end
		if @direction == "desc"
			@findings = @findings.reverse
		end
	elsif @display_as == "Experiments"
		@experiments = Experiment.find_with_index(@search_text)
		if @sort == "task"
			@experiments = @experiments.sort_by{|f| f.task_desc}
		elsif @sort == "year"
			@experiments = @experiments.sort_by{|f| f.paper.year}
		elsif @sort == "title"
			@experiments = @experiments.sort_by{|f| f.paper.title}
		else
			@experiments = @experiments.sort_by{|f| f.paper.authors.first.last_name}
		end
		if @direction == "desc"
			@experiments = @experiments.reverse
		end
	else
		@papers = Paper.find_with_index(@search_text)
		if @sort == "title"
			@papers = @papers.sort_by{|f| f.title}
		elsif @sort == "author"
			@papers = @papers.sort_by{|f| f.author.first.last_name}
		else
			@papers = @papers.sort_by{|f| f.year}
		end
		if @direction == "desc"
			@papers = @papers.reverse
		end
	end
	
	respond_to do |format|
	  format.html # search_comps.html.erb
	end
  end
  
  private
  
  def sort_column(display_as)
    if display_as == "Findings"
		%w[finding year author paper].include?(params[:sort]) ? params[:sort] : "finding"
	elsif display_as == "Experiments"
		%w[experiments.task_desc papers.year author papers.title].include?(params[:sort]) ? params[:sort] : "experiments.task_desc"
	else
		%w[title year authors.last_name].include?(params[:sort]) ? params[:sort] : "title"
	end
  end
  
  def sort_direction
    params[:direction] || "asc"
	#%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end