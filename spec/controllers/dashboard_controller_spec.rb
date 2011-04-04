require 'spec_helper'

describe DashboardController do
  it "generates urls" do
    controller.stub(:authenticate)
    debugger
    controller.inspect
    get :index
  end
end
