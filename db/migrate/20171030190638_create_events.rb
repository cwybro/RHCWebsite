class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.datetime :datetime  # A DateTime object for the event start time.
      t.text :address

      t.timestamps
    end
  end
end
