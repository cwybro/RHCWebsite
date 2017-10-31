class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.datetime :datetime
      t.text :address

      t.timestamps
    end
  end
end
