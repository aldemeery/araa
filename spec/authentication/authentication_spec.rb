require_relative '../rails_helper'

RSpec.feature 'Authentication', type: :feature do
  scenario 'Log in and log out' do
    user1 = User.new(full_name: 'User Example', username: 'userexample')
    user2 = User.new(full_name: 'Second User', username: 'user2')

    File.open(File.expand_path('spec/pixel.png')) do |f|
      user1.cover_image = f
      user1.photo = f
      user2.cover_image = f
      user2.photo = f
    end
    user1.save
    user2.save

    visit login_path
    have_link 'Login', href: login_path
    have_link 'Sign up', href: signup_path
    click_link 'Sign up'
    expect(page.current_path).to eq signup_path
    have_link 'Login', href: login_path
    click_link 'Login'
    expect(page.current_path).to eq login_path
    page.fill_in 'username', with: 'userexample'
    click_button 'Login'
    expect(page.current_path).to eq root_path
    have_link 'Home', href: root_path
    have_link 'Profile', href: user_path(user1.id)
    have_link 'Logout', href: logout_path
    have_link 'Second User', href: user_path(user2.id)
    click_on 'Logout'
    expect(page.current_path).to eq login_path
  end
end
