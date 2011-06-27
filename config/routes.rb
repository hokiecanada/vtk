Vtk::Application.routes.draw do

	devise_for :users do
		resources :papers do
			resources :authors
			resources :experiments do
				resources :findings
			end
		end
		#resources :tasks
		#resources :comps
		#resources :metrics
		#resources :systems
	end
	
	resources :tasks
	resources :comps
	resources :metrics
	resources :systems
	resources :authors
	resources :relationships
	
	match "admin" => "accounts#admin"
	match "/papers/:paper_id/experiments" => "experiments#index"
	match "/papers/:id/edit" => "papers#edit"
	match "/papers/:paper_id/experiments/:id/edit" => "experiments#edit"
	match "/papers/:paper_id/experiments/:experiment_id/findings/:id/edit" => "findings#edit"
	match "/papers/:paper_id/confirm_authors" => "papers#confirm_authors"

	namespace :user do
		root :to => "accounts#home", :controller => "accounts"
	end
	
	root :to => "papers#index"
end
