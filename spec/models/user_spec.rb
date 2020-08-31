require_relative '../rails_helper'

RSpec.describe User, type: :model do
  context 'Validation tests' do
    it 'validates attributes - invalid' do
      user = User.new(full_name: '', username: '', photo: '', cover_image: '')
      expect(user.valid?).to be(false)
    end

    it 'validates attributes - valid' do
      user = User.new(full_name: 'Test User', username: 'testuser')
      File.open(File.expand_path('spec/pixel.png')) do |f|
        user.cover_image = f
        user.photo = f
      end
      expect(user.valid?).to be(true)
    end
  end

  context 'Association tests' do
    it 'has many opinions' do
      assc = User.reflect_on_association(:opinions)
      expect(assc.macro).to eq :has_many
    end

    it 'has many followings' do
      assc = User.reflect_on_association(:followings)
      expect(assc.macro).to eq :has_many
    end

    it 'has many followers' do
      assc = User.reflect_on_association(:followers)
      expect(assc.macro).to eq :has_many
    end
  end
end
