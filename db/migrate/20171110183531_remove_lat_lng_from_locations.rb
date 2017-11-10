class RemoveLatLngFromLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :latitude, :decimal
    remove_column :locations, :longitude, :decimal
  end
end
