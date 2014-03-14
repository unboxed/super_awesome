require_relative "./spec_helper"

describe "Teardown", type: :feature do
  it "clears the database" do
    visit "/topic/new"
    fill_in 'description', with: 'cuttlefish are cute'
    click_button 'Make Topic'

    expect(current_path).to include('/topic/1')

    visit "/teardown"

    visit "/topic/1"

    expect(page).to have_content("undefined")
  end
end
