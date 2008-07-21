class CreateZipCodes < ActiveRecord::Migration
  def self.up
    create_table :zip_codes do |t|
      t.string :zip_code
      t.string :state_abbreviation
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state

      t.timestamps
    end
    add_index :zip_codes, ["zip_code"],
      :name => "index_zip_code_on_zip_codes"
    add_index :zip_codes, ["latitude"],
      :name => "index_latitude_on_zip_codes"
    add_index :zip_codes, ["longitude"],
      :name => "index_longitude_on_zip_codes"
  end

  def self.down
    remove_index :zip_codes,
      :name => "index_longitude_on_zip_codes"
    remove_index :zip_codes,
      :name => "index_latitude_on_zip_codes"
    remove_index :zip_codes,
      :name => "index_zip_code_on_zip_codes"
    drop_table :zip_codes
  end
end
