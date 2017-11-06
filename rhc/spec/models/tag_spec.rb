require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "should be able to create a Tag model given a name for it" do
      tag = Tag.create!(name: "outdoors")
      expect(tag).to respond_to(:name)
  end


end
