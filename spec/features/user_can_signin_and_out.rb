require 'spec_helper'

describe "User can sign in and sign out" do
  let(:user) { User.create(email: "rmlatz@gmail.com", password: "password") }

  it "should let user sign in if they've signed up" do
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Go"
    expect(page).to have_content("Start")
  end

  it "should let user sign out if they've signed in" do
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Go"
    click_button "signout"
    expect(page).to have_content("Welcome New Player!")
  end

end
