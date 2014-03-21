require_relative "./spec_helper"

describe "Homepage", type: :feature do
  it "redirects to the new poll page" do
    visit "/"

    expect(current_path).to eq("/polls/new")
  end
end