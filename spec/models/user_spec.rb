require 'rails_helper'

RSpec.describe User, type: :model do
  it "can have a description" do
    user = User.new(description: "no more than 500 words")
    
    expect(user).to be_valid
  end
end
