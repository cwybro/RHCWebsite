class AddIsReviewedToEventAndRecap < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :is_reviewed, :boolean
    add_column :recaps, :is_reviewed, :boolean
  end
end
