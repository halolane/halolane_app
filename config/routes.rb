HalolaneApp::Application.routes.draw do 


  resources :pages


  resources :bookshelves


  resources :chapters


  resources :likememories


  resources :authentications
  resources :users
  resources :profiles
  resources :memories
  resources :sessions, only: [:new, :create, :destroy]
  resources :memories, only: [:create, :destroy, :edit]
  resources :invitations
  resources :password_resets
  resources :relationships

  resources :profiles do
    member {get "getvcf"}
  end

  resources :memories do
    member {get "like"}
    member {get "unlike"}
    member {get "zoomstory"}
  end

  get "password_resets/new"
  get "users/new"
  get "profiles/new"
  get '/login', :to => 'sessions#new', :as => :login

  root to: 'static_pages#home'
  resources :password_resets

  
  match '/about', to: 'static_pages#about'
  match '/pagenotfound', to: 'static_pages#pagenotfound'
  match '/storybooknotfound', to: 'static_pages#pagenotfound'
  match '/createstorybook', to: 'profiles#new'
  match '/story/updatetitle', to: 'memories#update_title'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'sessions#failure'
  match '/login/:verify_token', to: 'static_pages#home'
  match '/privacy', to: 'static_pages#privacy_policy'
  match '/resetsent', to: 'password_resets#confirm'
  match '/confirmationsent', to: 'users#resend_validation'
  match '/editstory', to: 'memories#edit'
  match '/changerelationship', to: 'relationships#edit'
  match '/bookshelf/:invitation_token', to: 'invitations#show'

  #This must be last of the match statements
  match '/:url/chapter/:chapter_num/page/:page_num', to: 'profiles#show'
  match '/:url/chapter/:chapter_num', to: 'profiles#show'
  match '/:url', to: 'profiles#show'
  match '/:url/:invitation_token', to: 'invitations#show'


  


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
