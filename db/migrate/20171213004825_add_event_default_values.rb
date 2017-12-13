class AddEventDefaultValues < ActiveRecord::Migration[5.1]
  def change
      change_column :events, :is_reviewed, :boolean, :default => false
      change_column :events, :featured, :boolean, :default => false
  end
end
