class RemoveUserRecapLink < ActiveRecord::Migration[5.1]
  def change
    remove_column :recaps, :user_id, :integer
  end
end
