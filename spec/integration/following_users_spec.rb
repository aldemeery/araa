require_relative '../rails_helper'

RSpec.feature 'Following', type: :feature do
  before :each do
    @user1 = User.new(full_name: 'User One', username: 'user1')
    @user2 = User.new(full_name: 'User Two', username: 'user2')
    File.open(File.expand_path('spec/pixel.png')) do |f|
      @user1.cover_image = f
      @user1.photo = f
      @user2.cover_image = f
      @user2.photo = f
    end
    @user1.save
    @user2.save

    visit login_path
    page.fill_in 'username', with: 'user1'
    click_button 'Login'
  end

  scenario 'Following a user', type: :feature do
    have_link 'User Two', href: user_path(@user2.id)
    click_link 'User Two'
    expect(page.current_path).to eq user_path(@user2.id)
    expect(page).to have_text 'User Two'
    expect(page).to have_text '@user2'
    have_link href: follow_path(@user2.id)
    click_link href: follow_path(@user2.id)
    expect(page).to have_text @user2.full_name
    have_link href: unfollow_path(@user2.id)
  end
end
