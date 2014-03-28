LocatorBoard::Application.routes.draw do
	resources :user
	root 'locator_board#index'
end
