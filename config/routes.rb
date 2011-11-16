Gigavine::Application.routes.draw do
  
  # Assets
  get '/javascripts/:bundle.js' =>  JavascriptMinifier
  get "/stylesheets/:media.:ext" => SassCompiler
  #get '/', :to => 'sessions#new' #, :as => 'dashboard'
  # Sign In, Sign Out and Sign Up 
  get '/temp' =>'pages#temp_home'
  get    '/sign_in'                 => 'sessions#new',     :as => :sign_in
  post   '/sign_in'                 => 'sessions#create'
  get    '/auth/:provider/callback' => 'sessions#oauth'
  get    '/sign_out'                => 'sessions#destroy', :as => :sign_out

  get    'sign_up/(:invite_token)'  => 'users#new', :as => :sign_up
  post   'sign_up'  => 'users#create'
  get    'activate/:verification_token' => 'users#verify'
    get '/clients/signup' => 'users#client_signup'
    post '/clients/registration_page' => 'users#create_client_registration'
post '/talents/registration_page' => 'users#create_talent_registration'
get '/talents/registration' => 'users#talent_registration'

  # Profile and password reset
  get '/profile'           => 'users#edit',        :as => :profile
  get '/profile/feedback'   => 'users#feedback',   :as => :feedback
  get '/profile/statistics' => 'users#statistics', :as => :statistics
  put '/profile' => 'users#update'
  
  get  '/forgot_password' => 'passwords#new'
  post '/forgot_password' => 'passwords#create'
  
  get '/change_password/:password_reset_token'  => 'passwords#edit', :as => :change_password
  put '/change_password'                        => 'passwords#update' 
  get '/change_password'                        => 'passwords#edit'  
  
  get '/profile'           => 'users#edit',       :as => :profile
  
  # CRM/PMS
  
  #### Client Signup
  get 'signup/(:invite_token)' => 'users#signup', :as => :signup
  match 'signup' => 'users#gigauser_create'
  ##### end client signup 
  
    ### Client User Signup 
  
  get '/contact/signup/(:invite_token)' => 'users#client_user_signup', :as => :usersignup
  match '/contact/signup' => 'users#client_user_create'
  
  ### end client user signup
  
  
  
  get '/welcome' => "schedule/schedule#show"  
  get '/dashboard' => "schedule/schedule#dashboard"  
  get '/client/glossary' => "schedule/schedule#glossary" 
  get '/client/glossary/:id' => "schedule/schedule#glossary", :as => :flagged_terms   
  get '/client/glossary/search/:letter' => "schedule/schedule#search", :as => :glossary_search
  
  get '/addflag' => "schedule/schedule#add_flag",:as => :addflag  
  get '/deletetag' => "schedule/schedule#tag_delete",:as => :deletetag  
  get '/autocomplete_sentence_text' => "schedule/schedule#autocomplete_sentence_text",:as => :sentence_search
  
  get '/new_sentence' => 'schedule/schedule#new_sentence',:as => :new_sentence
  post '/create_sentence' => 'schedule/schedule#create_sentence',:as => :create_sentence  
  
  get '/edit_sentence' => 'schedule/schedule#edit_sentence',:as => :edit_sentence  
  put '/update_sentence' => 'schedule/schedule#update_sentence',:as => :update_sentence  
  
  get '/glossary/recent_activity' => 'schedule/schedule#recent_activity',:as => :recent_activity  
  get '/glossary/delete_sentence' => 'schedule/schedule#delete_sentence',:as => :delete_sentence
  get '/client/glossary/tagsearch/:letter' => "schedule/schedule#tagsearch", :as => :tagsearch  
  
 get '/comments' => "schedule/schedule#comments",:as => :comments  
 post 'new_comment' => "schedule/schedule#create_comment"  
 get 'new_tag' => "schedule/schedule#new_tag"  
 post 'create_tag' => "schedule/schedule#create_tag"
 get '/delete_comment' => "schedule/schedule#comment_delete",:as => :delete_comment    
 get '/delete_translation' => "schedule/schedule#delete_translation",:as => :delete_translation  
 ### for clients admin  
  get '/contact/new' => "schedule/admin#new",:as => :new_contact  
  post '/contact/create_contact' => "schedule/admin#create",:as => :create_contact    
  get '/contacts/users' =>  "schedule/admin#index",:as => :users_list
  get '/contact/user_invitation' => "schedule/admin#user_invitation",:as => :user_invitation
  post '/contact/allow_user/:id' => "schedule/admin#user_access",:as => :allow_user
  
  
  get '/contact/delete_user/:id' => "schedule/admin#contact_delete",:as => :contact_delete
  get '/contact/edit/:id' => "schedule/admin#edit_contact",:as => :contact_edit
  put '/contact/update/:id' => "schedule/admin#update_contact",:as => :contact_update  
 ### end for clients admin  

   ### for clients images  

  get '/clients/images' =>  "schedule/manage_images#index",:as => :images_list
  get '/images/new' => "schedule/manage_images#new",:as => :new_image  
  post '/images/create_image' => "schedule/manage_images#create",:as => :create_image  
  get '/image/edit/:id' => 'schedule/manage_images#edit',:as => :edit_image  
  put '/image/update/:id' => 'schedule/manage_images#update',:as => :update_image 
  get '/images/delete_image' => "schedule/manage_images#destroy",:as => :delete_image 
  get '/images/download_image' => "schedule/manage_images#download_image",:as => :download_image   
  get '/images/preview/:id' => "schedule/manage_images#view_uploadimage",:as => :view_uploadimage 
  get '/autocomplete_manage_image_subject' => "schedule/manage_images#autocomplete_manage_image_subject",:as => :image_search   
  ### end for clients images  



  #~ get '/client/flagged' => "schedule/schedule#flagged"    
    
    constraints :subdomain => "nkumar" do
      
      resources :leads
    end
  
  
  
  
  
  constraints :subdomain => "worx" do
       
    get '/', :to => 'sessions#new'       
    
  # Contacts
    resources :contacts, :module => 'contacts' do
      resources :details
      post 'invite', :on => :member
      
      collection do
        resources :organisations
      end
    end
  
    resources :leads, :module => 'leads' do
  
      collection do
        resources :imports
      end
    end
    
        
    resources :manage_images, :module => 'images' do
     collection do
            get 'download_image'
            get 'view_uploadimage' 
            get 'search'
            get 'autocomplete_manage_image_subject'
      end
    end
    
    
    
    
    
    namespace :glossary do
      get '/', :to => 'sentences#index'
      resources :sentences do
        collection do
          get 'recent'
          get 'flagged'
          get 'autocomplete_sentence_text'
          get 'move_flag'
        end
        put 'flag', :on => :member
        resources :translation_pairs
        resources :comments, :only => [:create, :destroy]
        resources :tags,     :only => [:create, :destroy, :index]
      end
    end
    
    namespace :schedule do
      # have different schedules for different people?
      get '/' => 'schedule#show'
      #resources: events -- a wrapper? or different resources for different events?
    end
    
    
  end
  
  
     resources :documents, :module => 'documents' do
        collection do         
          get 'document_download'
          get 'view_document'
          get 'show_information'
          post 'create_source_document'
          get 'multi_file_upload'
          post 'multifile_create'
          
          
          ### Google Doc
	   get 'googledoc_list'
	   get 'googledocument_download'
	   get 'view'
	   post 'update_doc_folder'
	   post 'add_user'
	   get 'edit'	  
	   get 'doc_delete'
	   get 'remove_user'
 
	   post 'save_content'	  

         
        end
    end
 
  resources :source_document, :module => 'documents' do
     collection do
           
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
    root :to => 'dashboard#index'
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :users
    resources :groups
    resources :sub_groups
    resources :clients


         resources :prospects do
		 post :move_to ,:on => :collection
     get :brief_details ,:on => :collection
     get :brief_details_download,:on => :collection
	 end 


      resources :leads do

	    get :delete_all, :on => :collection
	    post :edit_leads,:on => :collection
	    post :appoint_to,:on => :collection
	    post :csv_import,:on => :collection
    end
    
        resources :employees do 
	    get :dashboard,:on => :collection
	    get :graph_code,:on => :collection
    end
    #~ resources :employees
    resources :talents
    resources :suppliers
    resources :departments
    resources :languages
    resources :skills
  end
  
  # Static pages
  #constraints :subdomain => "test" do
    #get '/' => 'pages#show'
    get '/' => 'pages#home_land'
    get '/home' => 'pages#home_land'
    get '/languages' => 'pages#languages_new'
    get '/creative' => 'pages#creative_new'
    get '/technology' => 'pages#technology_new'
    
    get '/projects' => 'pages#projects_land' 
    get '/projects/case-studies'=> 'pages#projects_case_studies'      
    
    
    get '/network' => 'pages#network_land'  
    get '/network/featured'=> 'pages#network_featured' 

    get '/languages/copywriting' => 'pages#languages_writing'
    get '/languages/translation'=> 'pages#language_translation'   
    get '/languages/localisation' => 'pages#language_localisation'
    get '/languages/consultancy' => 'pages#language_consultancy'
    #~ get '/languages/online-tools' => 'pages#language_tools'    
    
    
    
    get '/creative/artwork' => 'pages#creative_work'  
    get '/creative/advertising' => 'pages#creative_adv'        
    get '/creative/webdesign' => 'pages#creative_design'
    #~ get '/creative/copywriting' => 'pages#creative_writing'
    get '/creative/interactive' => 'pages#creative_interactive'        
    
    
    
    
    get '/technology/e-learning' => 'pages#technology_learning'
    get '/technology/e-commerce' => 'pages#technology_commerce'     
    get '/technology/online-security' => 'pages#technology_secure' 
    get '/technology/online-tools' => 'pages#technology_tools'
    #~ get '/technology/crm' => 'pages#technology_crm'     
    
    get '/submenu'=> 'pages#submenu'
    post '/home_create' => 'pages#home_create'    
    post '/language_create' => 'pages#language_create'
    post '/creative_create' => 'pages#creative_create'
    post '/technology_create' => 'pages#technology_create'
  
    post '/projects_create' => 'pages#projects_create'
    
    post '/banner_create' => 'pages#banner_create'
    post '/help_connect' => 'pages#help_connect'

    get '/contact' => 'pages#contactus'
				get '/privacypolicy' => 'pages#privacypolicy'
    get '/terms' => 'pages#terms'
    get 'contactus' => 'pages#index'        
    post 'submit_brief' => 'pages#submit_brief'
    
    post 'submitbrief/:id' =>'pages#submit_brief_pages'
   
    post 'estimate' => 'pages#get_estimate'   
    post 'create_contact' => 'pages#lead_create'
    get "(:locale)/:section(/:page)" => 'pages#show', :constraints => { :section => /(#{Gigavine::Preferences.site_sections.join('|')})/,
                                                                      :locale  => /(#{Gigavine::Preferences.site_locales.join('|')})/,
                                                                      :page    => /[a-z_\-]+/ }
    get "search" => 'pages#search', :as => :site_search
    resources :contacts, :only => [ :create ]
    resources :blog_posts
    
  #end
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#temp_home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
