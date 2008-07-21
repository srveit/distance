# Represents a location in latitude/longitude

class Float
  
  def to_radians
    Math::PI * self / 180.0
  end

  def to_degrees
    180.0 * self / Math::PI
  end
end

class Location

  include Math

  attr_accessor :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def miles_to(location)
    distance = (sin(self.latitude.to_radians) *
                sin(location.latitude.to_radians) +
                cos(self.latitude.to_radians) *
                cos(location.latitude.to_radians) *
                cos((self.longitude - location.longitude).to_radians))

    acos(distance).to_degrees * 69.09
  end

  def miles_to_latitude_length(miles)
    # Taken from http://www.csgnetwork.com/degreelenllavcalc.html
    lat = self.latitude.to_radians

    m1 = 69.054795		# latitude calculation term 1
    m2 = -0.347856		# latitude calculation term 2
    m3 = 0.00073011		# latitude calculation term 3
    m4 = -1.43e-6		# latitude calculation term 4

    # Calculate the length of a degree of latitude and longitude in miles
    miles_per_degree = m1 + (m2 * cos(2 * lat)) + (m3 * cos(4 * lat)) +
      (m4 * cos(6 * lat))
    miles / miles_per_degree
  end

  def miles_to_longitude_length(miles)
    # Taken from http://www.csgnetwork.com/degreelenllavcalc.html
    lat = self.latitude.to_radians

    p1 = 69.228729		# longitude calculation term 1
    p2 = -0.0581		# longitude calculation term 2
    p3 = 73.3e-6		# Longitude calculation term 3

    # Calculate the length of a degree of latitude and longitude in miles
    miles_per_degree = (p1 * cos(lat)) + (p2 * cos(3 * lat)) +
      (p3 * cos(5 * lat))
    miles / miles_per_degree
  end

  def bounding_box(radius_in_miles)
    [self.class.new(latitude + miles_to_latitude_length(radius_in_miles),
                    longitude + miles_to_longitude_length(radius_in_miles)),
    self.class.new(latitude - miles_to_latitude_length(radius_in_miles),
                   longitude - miles_to_longitude_length(radius_in_miles))
    ]
  end

  def distance_to(location)


    # Formula from this page:
    # http://www.usenet-replayer.com/faq/comp.infosystems.gis.html

    origin_lat = latitude.to_radians
    origin_long = longitude.to_radians
    dest_lat = location.latitude.to_radians
    dest_long = location.longitude.to_radians

    radius = (3937 + 3976) * 0.5 # Approx. radius of the earth in statute miles

    delta_long = dest_long - origin_long
    delta_lat = dest_lat - origin_lat
    a = (sin(delta_lat/2))**2 + cos(origin_lat) * cos(dest_lat) * (sin(delta_long/2))**2
    c = 2 * asin([1,sqrt(a)].min)
    d = radius * c

  end
end
