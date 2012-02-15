Vtk::Application.routes.draw do

	devise_for :users do
		resources :papers do
			resources :authors
			resources :experiments do
				resources :findings
				resources :exp_tasks do
					resources :findings
				end
			end
		end
	end
	
	resources :tasks
	resources :comps
	resources :metrics
	resources :systems
	resources :authors
	resources :relationships
	resources :author_papers
	resources :exp_tasks
	
	match "admin" => "accounts#admin"
	match "/papers/:paper_id/experiments" => "experiments#index"
	match "papers/new" => "papers#new"
	match "/papers/:id/edit" => "papers#edit"
	match "/papers/:id/experiments/" => "experiments#index"
	match "/papers/:paper_id/experiments/:id" => "experiments#show"
	match "/papers/:paper_id/experiments/:id/edit" => "experiments#edit"
	#match "/papers/:paper_id/experiments/:experiment_id/findings/:id" => "findings#show"
	#match "/papers/:paper_id/experiments/:experiment_id/findings/:id/edit" => "findings#edit"
	match "/papers/:paper_id/experiments/:experiment_id/exp_tasks/:id/edit" => "exp_tasks#edit"
	match "/papers/:paper_id/experiments/:experiment_id/exp_tasks" => "exp_tasks#index"
	match "/papers/:paper_id/experiments/:experiment_id/exp_tasks/:exp_task_id/findings" => "findings#index"
	match "/papers/:paper_id/experiments/:experiment_id/exp_tasks/:exp_task_id/findings/new" => "findings#new"
	#match "/papers/:id/confirm_authors" => "papers#confirm_authors"
	match "confirm_authors" => "papers#confirm_authors"
	match "num_experiments" => "papers#num_experiments"
	match "num_findings" => "experiments#num_findings"
	match "experiment_type" => "experiments#type"
	match "search" => "search#index"
	match "search_comps" => "search#search_comps"
	match "search_tasks" => "search#search_tasks"
	match "search_metrics" => "search#search_metrics"
	match "search_systems" => "search#search_systems"
	match "full_text_search" => "search#full_text_search"
	match "browse" => "browse#index"
	match "browse_comp" => "browse#browse_comp"
	match "browse_task" => "browse#browse_task"
	match "browse_metric" => "browse#browse_metric"
	match "browse_system" => "browse#browse_system"
	match "add_authors" => "papers#add_authors"
	match "controlled" => "experiments#controlled"
	match "practical" => "experiments#practical"
	match "/papers/:paper_id/experiments/:experiment_id/exp_tasks/new" => "exp_tasks#new"
	#match "/papers/:paper_id/experiments/:experiment_id/exp_tasks/:exp_task_id/findings" => "findings#index"
	match "doi" => "papers#doi"
	match "review" => "papers#review"
	match "confirm" => "papers#confirm"
	
	namespace :user do
		root :to => "accounts#home", :controller => "accounts"
	end
	
	root :to => "search#index"
end
