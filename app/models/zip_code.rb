require 'rubygems'
require 'ar-extensions'

class ZipCode < ActiveRecord::Base

  composed_of :location, :mapping => [%w[latitude latitude], %w[longitude longitude]]

  attr_accessor :distance

  def self.import_file(csv_file)
    field_names, data = read_file(csv_file)
    ZipCode.delete_all
    ZipCode.import field_names, data
  end

  def self.read_file(csv_file)
    File.open(csv_file) do |csv|
      header = csv.readline.strip
      field_names = header.split(/, +/).collect{|name| name.gsub('"', '').gsub(' ', '_').to_sym}
      data = []
      csv.each do |line|
        line.strip!
        values = line.split(/, +/).collect{|v| v.gsub('"', '')}
        data << values
      end
      [field_names, data]
    end
  end

  def self.find_nearby(params)
    location = Location.new(params[:latitude].to_f, params[:longitude].to_f)
    radius = params[:radius].to_f
    north_east, south_west = location.bounding_box(radius)
    zip_codes_in_box =
      find(:all, :conditions =>
           ["latitude >= ? and latitude <= ? and longitude >= ? and longitude <= ?",
            south_west.latitude, north_east.latitude,
            south_west.longitude, north_east.longitude])
    zip_codes_in_box.each do |zip_code|
      zip_code.distance = location.distance_to(zip_code.location)
    end
    zip_codes = zip_codes_in_box.select {|zip_code| zip_code.distance <= radius}
    zip_codes.sort_by(&:distance)
  end
end
