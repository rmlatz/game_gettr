require 'spec_helper'

describe "User can see questions and answer them" do
  let(:user) { User.create(email: "rmlatz@gmail.com", password: "password") }

  it "should show a user some questions" do
    login(user)
    expect(page).to have_content("What Piques Your Interest?")
  end

  it "should let a user answer some questions" do
    login(user)
    select('I Want it All', :from => 'genre')
    select('Show me EVERYTHING!', :from => 'platform')
    click_button("Go")
    expect(page).to have_content("Check'm Out")
  end

  def login(user)
    visit signin_path
    find('#session_email').set(user.email)
    find('#session_password').set(user.password)
    click_button "Go"
  end

end
