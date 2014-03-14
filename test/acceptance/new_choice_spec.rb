require_relative "./spec_helper"

describe "New Choice", type: :feature do

  before do
    visit "/topic/new"
    fill_in 'description', with: 'yes'
    click_button 'Make Topic'
  end

  it "contains 'a type choice' here textarea" do
    expect(page).to have_css("form input#choice")
  end

  it "contains a submit button" do
    expect(page).to have_css("form button[type=\"submit\"]")
  end

end
