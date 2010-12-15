require 'spec_helper'

describe Lead do
  
  # Activity types that imply change in status should roughly be: acquired verified (assigned)
  #
  # :imported    - the lead has been imported and verified coming from a database
  # :duplicated  - marks when the contact tried to re-enter the system by some other import or action
  # :assigned    - a lead is bound to a sales person
  # :requested   - the lead comes directly from the orgainzation ringing our offices
  # :contact     - the lead has been called or emailed
  # :no_interest - the lead expressed little interest in the current offer
  # :campaing    - the lead just received campaign information
  # :pro-forma   - the lead received a proforma invocie ?
  # :registered  - the lead has been just activated it's client account.
  #
  # You don't really need a lead status: the "temperature" can be read through the delta using the
  # last_status_update
  describe "statuses" do
    
    
    
  end
  
  describe "metrics" do
    
    before(:each) do
      Time.is 3.moths.ago do
        @lead = Factory :lead
      end
      
      @lead.status
    end
    
    it "can be queried by turnover time" do
      lead = nil      
      
    end
    
  end
  
  
  
end
