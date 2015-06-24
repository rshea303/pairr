require 'rails_helper'

describe "user" do
  it "can see page of matches" do
    user = User.new(description: "hello")

    visit dashboard_path

    expect(page).to have_content("Find Pairs")
  end

  it "can see first match" do
    user = User.create(nickname: "user", description: "hello")
    user1 = User.create(nickname: "user1", description: "hello")
    visit dashboard_path
    click_on("Find Pairs")

    expect(page).to have_content("user1")
    expect(page).to have_content("hello")
  end

  it "can reject a user" do
    user = User.create(nickname: "user", description: "hello")
    user1 = User.create(nickname: "user1", description: "hello")
    visit dashboard_path
    click_on("Find Pairs")
    
    counter = user.rejects.count
    click_on("Reject")

    expect(user.rejects.count).to eq(counter + 1)
  end
end
