require 'rails_helper'

RSpec.describe User, type: :model do
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

end
