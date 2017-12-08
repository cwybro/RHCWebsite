class AddFeaturedToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :featured, :boolean
  end
end
