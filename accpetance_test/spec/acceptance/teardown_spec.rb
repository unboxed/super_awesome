require_relative "./spec_helper"

describe "Teardown", type: :feature do
  it "clears the database" do
    visit "/polls/new"
    fill_in 'description', with: 'cuttlefish are cute'
    click_button 'Make Poll'

    @show_path = current_path

    expect(current_path).to match(/\/polls\/[a-z0-9-]+?/)

    system("echo \"truncate table polls cascade; truncate table votes cascade;\" | psql super_awesome_test")

    visit @show_path

    expect(page).to have_content("Not Found")
  end
end
