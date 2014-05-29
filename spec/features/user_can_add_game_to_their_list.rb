require 'spec_helper'

describe "User can save a game to their list" do
  let(:user) { User.create(email: "rmlatz@gmail.com", password: "password") }

  it "should show the user a page with extended game details" do
    login(user)
    select('I Want it All', :from => 'genre')
    select('Show me EVERYTHING!', :from => 'platform')
    click_button("Go")
    first(:link, "game_link").click
    click_button("Add This Game to Your List")
    expect(page).to have_content("Farming Simulator 14")
  end

  def login(user)
    visit "/signin"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

end
