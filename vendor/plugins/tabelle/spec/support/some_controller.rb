class SomeController < ApplicationController

  def index
    # @users = load_in_table User
  end

end

SomeController.append_view_path(File.join(File.dirname(__FILE__)))