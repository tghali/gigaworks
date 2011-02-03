# raise "-----"+File.expand_path('spec_helper', File.dirname(__FILE__))+"-----"
require File.expand_path('spec_helper.rb', File.dirname(__FILE__) )

class User < ActiveRecord::Base
  named_scope :with_status, lambda { |status| {:conditions => {:status => status}} }
end

class UsersController < ApplicationController
  
  def index
    @users = load_in_table User do |tabelle|
      tabelle.filterables %w( user_name first_name last_name )
      tabelle.sortables %w( user_name created_at updated_at)
      tabelle.scopes :with_status
    end
    
    render
  end
end

Dir.chdir(File.dirname(__FILE__)) do
  require 'factory_girl'
end

describe UsersController, :type => :controller do
    integrate_views
    
    before(:each) do
      5.times {Factory.create(:user)}
    end
    
    it "has a response" do
      get "index"
      p response.body
    end
  
end