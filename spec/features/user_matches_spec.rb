require 'rails_helper'

describe "user" do
  it "can see page of matches" do
    user = User.new(description: "hello")

    visit dashboard_path

    expect(page).to have_content("Find Pairs")
  end
end
