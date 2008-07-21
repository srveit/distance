require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Location do

  before do
    @location = Location.new(34.5, -87.0)
  end

  it 'should have a latitude' do
    @location.latitude.should == 34.5
  end

  it 'should have a longitude' do
    @location.longitude.should == -87.0
  end

  it 'should calculate distance' do
    @location.miles_to(Location.new(34.4, -87.1)).should be_close(8.955, 0.001)
  end

  it 'should calculate latitude length in miles' do
    @location.miles_to_latitude_length(68.93).should be_close(1, 0.0001)
  end

  it 'should calculate longitude length in miles' do
    @location.miles_to_longitude_length(57.07).should be_close(1, 0.0001)
  end

  it 'should calculate bounding box' do
    north_east, south_west = @location.bounding_box(1)

    north_east.latitude.should be_close(34.5 + 1 / 68.93, 0.0001)
    south_west.longitude.should be_close(-87.0 - 1 / 57.07, 0.0001)
  end

  it 'should calculate distance to another location' do
    @location.distance_to(Location.new(34.0, -88.0)).should be_close(66.71, 0.01)
  end
end
