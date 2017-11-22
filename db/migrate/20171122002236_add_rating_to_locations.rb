class AddRatingToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :rating, :decimal, precision: 10, scale: 0, default: 0
  end
end
