require_relative '../rails_helper'

RSpec.describe Following, type: :model do
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
  end

  it 'creates a valid following' do
    following = Following.new(follower_id: @user1.id, followed_id: @user2.id)
    expect(following).to be_valid
  end

  it 'creates a invalid following' do
    following = Following.new(follower_id: '', followed_id: '')
    expect(following).to_not be_valid
  end

  context 'Association tests' do
    it 'belongs to follower' do
      assc = Following.reflect_on_association(:follower)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to followed' do
      assc = Following.reflect_on_association(:followed)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
