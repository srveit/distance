require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ZipCode do

  fixtures :zip_codes

  before(:each) do
    @zip_code = ZipCode.new
  end

  it "should be valid" do
    @zip_code.should be_valid
  end

  it 'should have a location' do
    zip_codes(:one).location.latitude.should be_close(38.7573, 0.0001)
  end
  
  it "should import a CSV file" do
    ZipCode.import_file("#{fixture_path}zips.csv")
    zip_code = ZipCode.find_by_zip_code("35004")
    zip_code.city.should == "Moody"
    zip_code.state_abbreviation.should == "AL"
    zip_code.latitude.should be_close(33.606379, 0.0001)
    zip_code.longitude.should be_close(-86.50249, 0.0001)

    zip_code = ZipCode.find_by_zip_code("009HH")
    zip_code.city.should == ""
    zip_code.state_abbreviation.should == "PR"
    zip_code.latitude.should be_close(18.435287, 0.0001)
    zip_code.longitude.should be_close(-66.06653, 0.0001)
  end

  describe 'find_nearby' do

    before do
      @zip_codes = ZipCode.find_nearby(:latitude => 38.72,
                                       :longitude => -90.44,
                                       :radius => 9.7)
    end

    it "should include only nearby zip codes" do
      @zip_codes.length.should == 4
    end

    it 'should be sorted by distance' do
      @zip_codes.should == @zip_codes.sort_by(&:distance)
    end

    it 'should set the distance of each zip code' do
      zip_code = @zip_codes.find {|zip_code| zip_code.zip_code == '63044'}
      zip_code.distance.should be_close(2.73, 0.01)
    end
  end

end
