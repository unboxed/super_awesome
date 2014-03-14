require_relative "./spec_helper"

describe "New Topic", :type => :feature do
  before {
    visit "/topic/new"
  }

  it "returns html" do
    expect(page.response_headers['Content-Type']).to eq('text/html')
  end

  it "contains a description textarea" do
    expect(page).to have_css("form textarea#description")
  end

  it "contains a welcome intro message" do
    expect(page).to have_css("p#welcome")
  end

  it "contains a submit button" do
    expect(page).to have_css("form button[type=\"submit\"]")
  end

  it "submits the form somewhere" do
    fill_in 'description', with: 'cuttlefish are cute'
    click_button 'Make Topic'

    expect(current_path).to include('/topic/1')
    expect(page).to have_content('cuttlefish are cute')
  end
end
