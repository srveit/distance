require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/zip_codes/show.html.erb" do
  include ZipCodesHelper
  
  before(:each) do
    @zip_code = mock_model(ZipCode)
    @zip_code.stub!(:zip_code).and_return("1")
    @zip_code.stub!(:state).and_return("MyString")
    @zip_code.stub!(:latitude).and_return("1.5")
    @zip_code.stub!(:longitude).and_return("1.5")
    @zip_code.stub!(:city).and_return("MyString")

    assigns[:zip_code] = @zip_code
  end

  it "should render attributes in <p>" do
    render "/zip_codes/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/MyString/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/MyString/)
  end
end

