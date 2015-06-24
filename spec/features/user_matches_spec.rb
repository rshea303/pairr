require 'rails_helper'

describe "user" do

  it "can be stubbed" do
    user = User.create(nickname: "tom", description: "hello")
    user1 = User.create(nickname: "user1", uid: "123", description: "user1 desc")
    user2 = User.create(nickname: "user2", uid: "234", description: "user2 desc")
    user3 = User.create(nickname: "user3", uid: "345", description: "user3 desc")
    user.matches << Match.create(match_user_id: user1.id)
    user.matches << Match.create(match_user_id: user2.id)
    user.matches << Match.create(match_user_id: user3.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    expect(page).to have_content("Find Pairs")
  end

  it "can see page of matches" do
    user = User.new(description: "hello")

    visit dashboard_path

    expect(page).to have_content("Find Pairs")
  end

  it "can see first match" do
    user = User.create(nickname: "tom", description: "hello")
    user1 = User.create(nickname: "larry", description: "hello")
    user.matches << Match.create(match_user_id: user1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_on("Find Pairs")

    expect(page).to have_content("larry")
    expect(page).to have_content("hello")
  end

  it "can reject a user" do
    user = User.create(nickname: "user", description: "hello")
    user1 = User.create(nickname: "user1", description: "hello")
    user.matches << Match.create(match_user_id: user1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_on("Find Pairs")
    
    counter = user.rejects.count
    click_on("Reject")

    expect(user.rejects.count).to eq(counter + 1)
  end
  
  it "can become a pending for a user" do
    user = User.create(nickname: "user", description: "hello")
    user1 = User.create(nickname: "user1", description: "hello")
    user.matches << Match.create(match_user_id: user1.id)
    user1.matches << Match.create(match_user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user1.pendings.count).to eq(0)

    visit dashboard_path
    click_on("Find Pairs")
    click_on("Approve")

    expect(user1.pendings.count).to eq(1)
  end

end
