GoFishRails::Application.routes.draw do

	get 'users' => 'player#list'
	
  devise_for :users

	get 'play' => 'player#play', :as => :play
	get 'player/edit' => 'player#edit', :as => :address
	put 'player/update' => 'player#update', :as => :update
	get 'player/:id' => 'player#show', :as => :profile
	get 'player' => 'player#play'
	get 'players' => 'player#list'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  #get 'player/:id/play' => 'user#play', :as => :play
  #get 'player/:id/edit' => 'user#edit', :as => :edit
  #get 'player/:id' => 'user#show', :as => :user
  #put 'player/:id' => 'user#update'
  #post 'player/new' => 'user#register'
  #post 'player/:id' => 'user#update'
  #post 'player' => 'user#checkpoint'
  #put 'player/:id/update' => 'user#update', :as => :user
  #get 'players' => 'user#list'
  #get 'player/:id/reset' => 'user#reset'
  #get 'player/:id/reset/:token' => 'user#reset'

	get 'game/:id/end' => 'game#endgame', :as => :end
  post 'game/new' => 'game#new'
	get 'game/multi' => 'game#multi'
  get 'game/:id' => 'game#display', :as => :game
  post 'game/play' => 'game#play'
  
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :users

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html. 
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end