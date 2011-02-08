Gigavine::Application.routes.draw do

  # Assets
  get '/javascripts/:bundle.js' =>  JavascriptMinifier
  get "/stylesheets/:media.:ext" => SassCompiler
  
  # Sign In, Sign Out and Sign Up 
  get    '/sign_in'                 => 'sessions#new',     :as => :sign_in
  post   '/sign_in'                 => 'sessions#create'
  get    '/auth/:provider/callback' => 'sessions#oauth'
  get    '/sign_out'                => 'sessions#destroy', :as => :sign_out
  
  get    'sign_up/(:invite_token)'  => 'users#new', :as => :sign_up
  post   'sign_up'  => 'users#create'
  get    'activate/:verification_token' => 'users#verify'

  # Profile and password reset
  get '/profile'           => 'users#edit',       :as => :profile
  get 'profile/feedback'   => 'users#feedback',   :as => :feedback
  get 'profile/statistics' => 'users#statistics', :as => :statistics
  put '/profile' => 'users#update'
  
  get  '/forgot_password' => 'passwords#new'
  post '/forgot_password' => 'passwords#create'
  
  get '/change_password/:password_reset_token'  => 'passwords#edit', :as => :change_password
  put '/change_password'                        => 'passwords#update' 
  get '/change_password'                        => 'passwords#edit'  
  
  get '/profile'           => 'users#edit',       :as => :profile
  
  # CRM/PMS
  constraints :subdomain => "worx" do
  # Contacts
    resources :contacts, :module => 'contacts' do
      resources :details
  
      collection do
        resources :organisations
      end
    end
  
    resources :leads, :module => 'leads' do
  
      collection do
        resources :imports
      end
    end
    
    namespace :glossary do
      get '/(:language)', :to => 'glossary#index', :constraints => {:language => /[a-z]{2}/}
      
      resources :words do
        resources :definitions do
          resources :translations
        end
      end
      
      resources :sentences do
        resources :translation_pairs
      end
    end
    
    namespace :schedule do
      # have different schedules for different people?
      get '/' => 'schedule#show'
      #resources: events -- a wrapper? or different resources for different events?
    end
    
    get '/', :to => 'dashboard#index'
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
    root :to => 'admin#index'
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :users
  end
  
  # Static pages
  get "(:locale)/:section(/:page)" => 'pages#show', :constraints => { :section => /(#{Gigavine::Preferences.site_sections.join('|')})/,
                                                                    :locale  => /(#{Gigavine::Preferences.site_locales.join('|')})/,
                                                                    :page    => /[a-z_\-]+/ }
  get "search" => 'pages#search', :as => :site_search
  
  resources :blog_posts
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
