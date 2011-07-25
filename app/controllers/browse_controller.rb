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
	@findings = Finding.joins(:tasks).where(:tasks => {:id => @task})
	@experiments = Experiment.joins(:tasks).where(:tasks => {:id => @task})
	@papers = Paper.where(:id => @experiments.collect{|x| x.paper_id})
	respond_to do |format|
	  format.html # browse_task.html.erb
	end
  end
  
end