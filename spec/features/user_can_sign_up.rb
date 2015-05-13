require 'spec_helper'

describe "User can sign up" do

  it "lets user sign up" do
    visit signup_path
    fill_in :email, with: "rmlatz@gmail.com"
    find("#user_password").set("password")
    find("#user_password_confirmation").set("password")
    click_button("submit")
    expect(page).to have_content("Start")
  end

end
