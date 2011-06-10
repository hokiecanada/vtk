Vtk::Application.routes.draw do

	devise_for :users do
		resources :papers do
			resources :experiments do
				resources :findings
			end
		end
	end

	root :to => "papers#index"
end
