class LinkingUserToEventAndRecap < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :user_id, :integer
    add_column :recaps, :user_id, :integer
  end
end
