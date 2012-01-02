

namespace :user do
 desc "create delayedjos"
 
      task :sent_mail => :environment do 
             User.create(:user_name =>"aslati_new", :terms_of_service => "1", :privacy_policy=>"1", :contact_id => 2,  :status_code => 1, :role_mask => 1, :password => "indian123", :password_confirmation => "indian123")

      end

	
 end
