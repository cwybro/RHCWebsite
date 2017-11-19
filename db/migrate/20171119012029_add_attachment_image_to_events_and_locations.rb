class AddAttachmentImageToEventsAndLocations < ActiveRecord::Migration[4.2]
  def self.up
    change_table :events do |t|
      t.attachment :image
    end

    change_table :locations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :events, :image
    remove_attachment :locations, :image
  end
end
