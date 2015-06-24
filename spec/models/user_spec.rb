require 'rails_helper'

RSpec.describe User, type: :model do
  it "can have a nickname" do
    user = User.create(nickname: "nick", description: "desc")

    current_user = User.last

    expect(current_user.nickname).to eq("nick")
  end

  it "can have a description" do
    user = User.new(description: "no more than 500 words")
    
    expect(user).to be_valid
  end

  it "is valid with a description less than 500 characters" do
    user = User.new(description: "a" * 499)

    expect(user).to be_valid
  end

  it "is not valid with a description more than 500 characters" do
    user = User.new(description: "a" * 501)

    expect(user).not_to be_valid
  end

  it "has a language" do
    user = User.create(description: "desc")
    user.languages.create(name: "first language")

    expect(user.languages.count).to eq(1)
    expect(user.languages.first.name).to eq("first language")
  end
  
  it "has many languages" do
    user = User.create(description: "desc")
    user.languages.create(name: "first language")
    user.languages.create(name: "second language")
    user.languages.create(name: "third language")

    expect(user.languages.count).to eq(3)
    expect(user.languages.first.name).to eq("first language")
    expect(user.languages.last.name).to eq("third language")
  end

  it "has a list of rejects" do
    user = User.create(description: "desc")
    user1 = User.create(nickname: "user1", uid: "123", description: "user1 desc")
    user2 = User.create(nickname: "user2", uid: "234", description: "user2 desc")
    user3 = User.create(nickname: "user3", uid: "345", description: "user3 desc")

    expect(user.rejects.count).to eq(0)

    user.rejects << Reject.create(rejected_user_id: user1.id)
    user.rejects << Reject.create(rejected_user_id: user3.id)

    expect(user.rejects.count).to eq(2) 

    expect(User.find(user.rejects.first.rejected_user_id).nickname).to eq("user1")
    expect(User.find(user.rejects.last.rejected_user_id).nickname).to eq("user3")
  end

  it "has a list of approves" do
    user = User.create(description: "desc")
    user1 = User.create(nickname: "user1", uid: "123", description: "user1 desc")
    user2 = User.create(nickname: "user2", uid: "234", description: "user2 desc")
    user3 = User.create(nickname: "user3", uid: "345", description: "user3 desc")

    expect(user.selections.count).to eq(0)

    user.selections << Selection.create(selected_user_id: user1.id)
    user.selections << Selection.create(selected_user_id: user3.id)

    expect(user.selections.count).to eq(2) 

    expect(User.find(user.selections.first.selected_user_id).nickname).to eq("user1")
    expect(User.find(user.selections.last.selected_user_id).nickname).to eq("user3")
  end

  it "has a list of matches"  do
    user = User.create(description: "desc")
    user1 = User.create(nickname: "user1", uid: "123", description: "user1 desc")
    user2 = User.create(nickname: "user2", uid: "234", description: "user2 desc")
    user3 = User.create(nickname: "user3", uid: "345", description: "user3 desc")

    expect(user.matches.count).to eq(0)

    user.matches << Match.create(match_user_id: user1.id)
    user.matches << Match.create(match_user_id: user2.id)
    user.matches << Match.create(match_user_id: user3.id)

    expect(user.matches.count).to eq(3) 
  end

  it "has a list of pending matches" do
    user = User.create(nickname: "user", description: "desc")
    user1 = User.create(nickname: "user1", description: "user1 desc")

    user.matches << Match.create(match_user_id: user1.id)
    user1.matches << Match.create(match_user_id: user.id)

    expect(user.pendings.count).to eq(0)

    user.pendings << Pending.create(pending_user_id: user1.id)
    
    expect(user.pendings.count).to eq(1)
  end

end
