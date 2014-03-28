LocatorBoard::Application.routes.draw do
	resources :users
	root 'locator_board#index'
end
