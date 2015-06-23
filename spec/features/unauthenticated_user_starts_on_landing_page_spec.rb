require 'rails_helper'

describe "unauthenticated user" do
  it "begins site on landing page" do
    visit root_path

    expect(page).to have_content("Pairr")
    expect(page).to have_content("Sign In With Github")
  end
end
