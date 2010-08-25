Gigaworks::Application.routes.draw do

  root :to => 'home#index'

  # Assets
  get '/javascripts/:bundle.js' => JavascriptMinifier
  get "/stylesheets/:media.:ext" => SassCompiler
  
  # Sign In, Sign Out and Sign Up 
  get    'sign_in'  => 'sessions#new',     :as => :sign_in
  post   'sign_in'  => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy', :as => :sign_out
  
  # get  'sign_up'  => 'users#new', :as => :sign_up
  # post 'sign_up'  => 'users#create'
  get  'activate/:verification_token' => 'users#verify'

  # Profile and password reset
  get '/profile' => 'users#edit', :as => :profile
  put '/profile' => 'users#update' 
  
  get  '/forgot_password' => 'passwords#new'
  post '/forgot_password' => 'passwords#create'
  
  get '/change_password/:password_reset_token'  => 'passwords#edit', :as => :change_password
  put '/change_password'                        => 'passwords#update' 
  get '/change_password'                        => 'passwords#edit'  
  
  # Contacts
  resources :contacts, :module => 'contacts' do
    resources :details
  
    collection do
      resources :organizations
    end
  end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
    namespace :admin do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)
      resources :users
    end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
