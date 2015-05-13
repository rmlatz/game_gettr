require 'spec_helper'

describe "User can select a game from the list page and see more details" do
  let(:user) { User.create(email: "rmlatz@gmail.com", password: "password") }

  it "should show the user a page with extended game details" do
    login(user)
    select('I Want it All', :from => 'genre')
    select('Show me EVERYTHING!', :from => 'platform')
    click_button("Go")
    first(:link, "game_link").click
    expect(page).to have_selector("input[id='game_title']")
  end

  def login(user)
    visit signin_path
    find('#session_email').set(user.email)
    find('#session_password').set(user.password)
    click_button "Go"
  end

end
