require 'spec_helper'

describe "User can sign up" do

  it "lets user sign up" do
    visit signup_path
    fill_in "Email", with: "rmlatz@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button("submit")
    expect(page).to have_content("Start")
  end

end
