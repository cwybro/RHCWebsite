class CreateRecaps < ActiveRecord::Migration[5.1]
  def change
    create_table :recaps do |t|
      t.integer :attendance
      t.text :description
      t.integer :event_id
      t.timestamps
    end
  end
end
