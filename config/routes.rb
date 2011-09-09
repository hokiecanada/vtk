Vtk::Application.routes.draw do

	devise_for :users do
		resources :papers do
			resources :authors
			resources :experiments do
				resources :findings
			end
		end
	end
	
	resources :tasks
	resources :comps
	resources :metrics
	resources :systems
	resources :authors
	resources :relationships
	
	match "admin" => "accounts#admin"
	match "/papers/:paper_id/experiments" => "experiments#index"
	match "papers/new" => "papers#new"
	match "/papers/:id/edit" => "papers#edit"
	match "/papers/:paper_id/experiments/:id" => "experiments#show"
	match "/papers/:paper_id/experiments/:id/edit" => "experiments#edit"
	match "/papers/:paper_id/experiments/:experiment_id/findings/:id" => "findings#show"
	match "/papers/:paper_id/experiments/:experiment_id/findings/:id/edit" => "findings#edit"
	match "/papers/:paper_id/confirm_authors" => "papers#confirm_authors"
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

	namespace :user do
		root :to => "accounts#home", :controller => "accounts"
	end
	
	root :to => "search#index"
end
