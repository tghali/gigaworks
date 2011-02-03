require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class SomeModel
  
end

def create_table_builder(size, overwrite = nil)
  @table_parameters = {:view => nil, :filters => nil, :sort => nil, :page => 8,
                      :table_options => {:defaults => {:view => "list"},
                                         :total_entries => size,
                                         :items_per_page => {"list" => 20, "icons" => 12}
                                         }
                      }
  @table_parameters.merge! overwrite if overwrite
  item = SomeModel.new.stub! :class => SomeModel
  @collection = []
  20.times do
    @collection << item
  end
  TableBuilders::TableBuilder.new(@table_parameters, @collection, @object)  
end

describe "controller parameters retrival" do
  it "should have it's own copy of the relevant params" do
    pending
  end
end

describe "view options handling" do
  it "should default to a view" do
    pending
  end
  
  it "should provide links to other view" do
    pending
  end
end

describe "filter form methods" do
  it "should return params without the filters" do
    pending
  end
  
  it "should return a link of params except the filter passed" do
    pending
  end
end

describe "sort link creation" do
  it "should create a sort link to order the elements" do
    builder = create_table_builder(10)
    builder.params_with_sort("updated_at")[:sort].should eql("updated_at")
    builder.params_with_sort("updated_at")[:page].should eql(8)
  end
  
  it "should create a sort link that inverts the current order" do
    builder = create_table_builder(10, :sort => "updated_at")
    builder.params_with_sort("updated_at")[:sort].should eql("-updated_at")
    builder.params_with_sort("updated_at")[:page].should eql(8)
  end
  
  it "should error if a sortable link is requested for a non-sortable column" do
    builder = create_table_builder(10, :sort => "ciccio")
    lambda { builder.params_with_sort("ciccio")[:sort].should eql("ciccio") }.should raise_error("Column ciccio not sortable")
  end
  
end

describe "pagination basic methods" do
  before :each do
    @builder = create_table_builder(310)
  end
  
  it "should return the page count" do
    @builder.total_pages.should eql(15)
  end
  
  it "should return a link for the page" do
    @builder.pagination_params(4)[:page].should eql(4)
  end
  
  it "should not link anywhere on the current page" do
    @builder.pagination_params(8).should eql("#")
  end
  
  it "should not link anywhere on the current page, when it's page 1" do
    builder = create_table_builder(310, :page => nil)
    builder.pagination_params(1).should eql("#")
  end
  
  it "should return a next and return parameters" do
    @builder.pagination_params("next")[:page].should eql(9)
    @builder.pagination_params(">")[:page].should eql(9)
    @builder.pagination_params("previous")[:page].should eql(7)
    @builder.pagination_params("<")[:page].should eql(7)
  end
  
  it "should return a proper link for the last page" do
    @builder.pagination_params("last")[:page].should eql(15)
    @builder.pagination_params(">>")[:page].should eql(15)
  end
  
  it "should return the array without the page param" do
     @builder.pagination_params("first").should_not have_key(:page)
     @builder.pagination_params("<<").should_not have_key(:page)
     @builder.pagination_params(1).should_not have_key(:page)
  end
end

describe "pagination with arrows" do
  it "should return an array of 7 pages with arrows" do
    @builder = create_table_builder(310)
    @builder.pagination_with_arrows.should eql(["<<", "<", 5, 6, 7, 8, 9, 10, 11, ">", ">>"])
  end
  
  it "should return the first 8 pages if the entire collection is small ehough" do
    7.times do |page|
      @builder = create_table_builder(140, :page => page)
      @builder.pagination_with_arrows.should eql(["<<", "<", 1, 2, 3, 4, 5, 6, 7, ">", ">>"])
    end
  end
  
end

describe "pagination with ellipsis" do
  it "should return an array of 7 pages with extremes" do
    @builder = create_table_builder(310)
    @builder.pagination_with_ellipsis.should eql([1, "&hellip;", 5, 6, 7, 8, 9, 10, 11, "&hellip;", 15])
  end
  
  it "should return the first 8 pages plus ellipsis if page < 4" do
    @builder = create_table_builder(310, :page => 4)
    @builder.pagination_with_ellipsis.should eql([1, 2, 3, 4, 5, 6, 7, 8, "&hellip;", 15])
  end
  
  it "should return the first 8 pages if the entire collection is small ehough" do
    9.times do |page|
      @builder = create_table_builder(180, :page => page)
      @builder.pagination_with_ellipsis.should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end
  
  it "should return the 7 last pages plus an ellipsis to the first if in the last four pages" do
    (12..15).each do |page|
      @builder = create_table_builder(301, :page => page)
      @builder.pagination_with_ellipsis.should eql([1, "&hellip;", 9, 10, 11, 12, 13, 14, 15])
    end
  end
  
  it "should not use the ellispsis when it stands for only one number" do
    builder = create_table_builder(301, :page => 6)
    builder.pagination_with_ellipsis.should eql([1, 2, 3, 4, 5, 6, 7, 8, 9, "&hellip;", 15])
    builder = create_table_builder(301, :page => 11)
    builder.pagination_with_ellipsis.should eql([1, "&hellip;", 8, 9, 10, 11, 12, 13, 14, 15])
    
  end
end