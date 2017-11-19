class AddAddressToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :address, :text
    add_column :locations, :lat, :decimal, precision: 15, scale: 10
    add_column :locations, :lng, :decimal, precision: 15, scale: 10
  end
end
