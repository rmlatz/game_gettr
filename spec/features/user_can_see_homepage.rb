require 'spec_helper'



describe "A User can see the homepage" do

  it 'has the title This is the HomePage' do
    visit root_path
    expect(page).to have_content "Welcome New Player!"
  end

end # End describe user can see homepage
