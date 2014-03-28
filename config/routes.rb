LocatorBoard::Application.routes.draw do
	resources :users
	resources :people_relationships
	root 'locator_board#index'
end
