require 'rails_helper'

RSpec.describe Language, type: :model do
  it "is valid with a name" do
    language = Language.create(name: "New language")

    language1 = Language.last

    expect(language1.name).to eq("New language")
  end

  it "is not valid without a name" do
    language = Language.new(name: nil)

    expect(language).not_to be_valid
  end
end
