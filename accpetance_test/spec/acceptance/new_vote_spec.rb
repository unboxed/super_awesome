require_relative "./spec_helper"

describe "New Vote", type: :feature do

  before do
    visit "/polls/new"
    fill_in 'description', with: 'yes'
    click_button 'Make Poll'
  end

  it "contains 'a type choice' here textarea" do
    expect(page).to have_css("form input#choice")
  end

  it "contains a submit button" do
    expect(page).to have_css("form button[type=\"submit\"]")
  end

end


describe "Submitting a choice", type: :feature do

  before do
    visit "/polls/new"
    fill_in 'description', with: 'do you like cheese'
    click_button 'Make Poll'

    @show_path = current_path

    fill_in 'choice', with: 'who doesnt!'
    click_button 'Vote'
  end

  it "redirects to the topic result page" do
    expect(current_path).to match(/\/polls\/[a-z0-9-]+?\/results/)
  end

end


