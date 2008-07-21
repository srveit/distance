require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/zip_codes/index.html.erb" do
  include ZipCodesHelper
  
  before(:each) do
    zip_code_98 = mock_model(ZipCode)
    zip_code_98.should_receive(:zip_code).and_return("1")
    zip_code_98.should_receive(:distance).at_least(:once).and_return(nil)
    zip_code_98.should_receive(:state).and_return("MyString")
    zip_code_98.should_receive(:state_abbreviation).and_return("MS")
    zip_code_98.should_receive(:latitude).and_return("1.5")
    zip_code_98.should_receive(:longitude).and_return("1.5")
    zip_code_98.should_receive(:city).and_return("MyString")
    zip_code_99 = mock_model(ZipCode)
    zip_code_99.should_receive(:zip_code).and_return("1")
    zip_code_99.should_receive(:distance).at_least(:once).and_return(nil)
    zip_code_99.should_receive(:state).and_return("MyString")
    zip_code_99.should_receive(:state_abbreviation).and_return("MS")
    zip_code_99.should_receive(:latitude).and_return("1.5")
    zip_code_99.should_receive(:longitude).and_return("1.5")
    zip_code_99.should_receive(:city).and_return("MyString")

    zip_codes = [zip_code_98, zip_code_99]
    zip_codes.stub!(:total_pages).and_return(1)
    assigns[:zip_codes] = zip_codes
  end

  it "should render list of zip_codes" do
    render "/zip_codes/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

