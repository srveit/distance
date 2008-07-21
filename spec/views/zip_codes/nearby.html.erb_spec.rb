require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/zip_codes/nearby.html.erb" do
  include ZipCodesHelper
  
  before(:each) do
    zip_code_98 = mock_model(ZipCode)
    zip_code_98.should_receive(:zip_code).and_return("63031")
    zip_code_98.should_receive(:distance).at_least(:once).and_return(2.5)
    zip_code_98.should_receive(:city).and_return("Florissant")
    zip_code_98.should_receive(:state_abbreviation).and_return("MO")
    zip_code_98.should_receive(:latitude).and_return("1.5")
    zip_code_98.should_receive(:longitude).and_return("1.5")
    zip_code_99 = mock_model(ZipCode)
    zip_code_99.should_receive(:zip_code).and_return("1")
    zip_code_99.should_receive(:distance).at_least(:once).and_return(3.5)
    zip_code_99.should_receive(:city).and_return("MyString")
    zip_code_99.should_receive(:state_abbreviation).and_return("IL")
    zip_code_99.should_receive(:latitude).and_return("1.5")
    zip_code_99.should_receive(:longitude).and_return("1.5")

    assigns[:zip_codes] = [zip_code_98, zip_code_99]
  end

  it "should render list of zip_codes" do
    render "/zip_codes/nearby.html.erb"

    response.should have_tag("tr>td", "63031", 1)
    response.should have_tag("tr>td", "MO", 1)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "Florissant", 1)

    response.should have_tag("form[action=/zip_codes/nearby]")
  end
end

