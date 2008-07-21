require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/zip_codes/new.html.erb" do
  include ZipCodesHelper
  
  before(:each) do
    @zip_code = mock_model(ZipCode)
    @zip_code.stub!(:new_record?).and_return(true)
    @zip_code.stub!(:zip_code).and_return("1")
    @zip_code.stub!(:state).and_return("MyString")
    @zip_code.stub!(:latitude).and_return("1.5")
    @zip_code.stub!(:longitude).and_return("1.5")
    @zip_code.stub!(:city).and_return("MyString")
    assigns[:zip_code] = @zip_code
  end

  it "should render new form" do
    render "/zip_codes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", zip_codes_path) do
      with_tag("input#zip_code_zip_code[name=?]", "zip_code[zip_code]")
      with_tag("input#zip_code_state[name=?]", "zip_code[state]")
      with_tag("input#zip_code_latitude[name=?]", "zip_code[latitude]")
      with_tag("input#zip_code_longitude[name=?]", "zip_code[longitude]")
      with_tag("input#zip_code_city[name=?]", "zip_code[city]")
    end
  end
end


