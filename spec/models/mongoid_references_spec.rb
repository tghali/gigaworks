require 'spec_helper'

class Instructor
  include Mongoid::Document
  
  embeds_many     :courses
  references_many :cool_rides
  
  # references_many :trusted_collegues, :class_name => 'Instructor' #- raises NoMethodError 'entries' for #<Instructor:0x1062f1e10>
  references_and_referenced_in_many :trusted_collegues, :class_name => 'Instructor'
end

class Course
  include Mongoid::Document
  embedded_in :instructor
  
  # references_many :substitutes, :class_name => 'Instructor' #- raises NoMethodError 'first' for #<Course _id: 4d49eade8b8e6b955a000004, name: "First Aid"> 
  references_and_referenced_in_many :substitutes, :class_name => 'Instructor'
end

class CoolRide
  include Mongoid::Document
  referenced_in :instructor
end


describe "mongoid" do
    
  context "references_and_referenced_in_many seems to be the only way to" do
    
    it "build on a references_may" do
      mitch = Instructor.create(:name => 'Mitch Buchannon')
      mitch.trusted_collegues.create(:name => 'Newmie')
      
      mitch.trusted_collegues.should_not be_empty
    end
    
    it "build inside an embedded document" do
      mitch = Instructor.create(:name => 'Mitch Buchannon')
      
      first_aid = mitch.courses.create(:name => 'First Aid')
      
      first_aid.substitutes.build(:name => 'C.J. Parker')
    end
    
  end
  
  context "references_many" do
    
    it "builds from the referenced" do
      jetski = CoolRide.create(:type => 'Jet Ski', :color => '#DB3920')
      
      mitch = Instructor.create(:name => 'Mitch Buchannon')
      
      mitch.cool_rides << jetski
      
      mitch.cool_rides.build
      
      mitch.cool_rides.size.should eql(2)
    end
    
  end
  
end