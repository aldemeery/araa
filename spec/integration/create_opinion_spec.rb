require_relative '../rails_helper'

RSpec.feature 'Create Opinion', type: :feature do
  before :each do
    user = User.new(full_name: 'User Name', username: 'username')
    File.open(File.expand_path('spec/pixel.png')) do |f|
      user.cover_image = f
      user.photo = f
    end
    user.save

    opinion = user.opinions.build(text: 'Test opinion')
    opinion.save
    visit login_path
    page.fill_in 'username', with: 'username'
    click_button 'Login'
  end

  scenario 'Opinion creation', type: :feature do
    expect(page.current_path).to eq root_path
    page.fill_in 'opinion[text]', with: 'Test opinion'
    click_button 'Post'
    expect(page).to have_text 'Test opinion'
    expect(page).to have_text 'less than a minute ago'
  end
end
