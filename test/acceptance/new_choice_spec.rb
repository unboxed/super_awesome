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


describe "Submitting a choice", type: :feature do

  before do
    visit "/topic/new"
    fill_in 'description', with: 'do you like cheese'
    click_button 'Make Topic'

    fill_in 'choice', with: 'who doesnt!'
    click_button 'Vote on topic'
  end

  it "redirects to the topic result page" do
    expect(current_path).to eq('/topic/1/result')
  end

  it "displays my choice submission" do
    expect(page).to have_content('who doesnt!')
  end

  it "counts multiple submissions of the same choice" do
    visit "/topic/1"
    fill_in 'choice', with: 'who doesnt!'
    click_button 'Vote on topic'

    expect(page).to have_content('2')
  end

end


