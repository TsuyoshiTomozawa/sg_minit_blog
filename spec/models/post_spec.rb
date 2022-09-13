require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'in valid case' do
    it 'is valid with content' do
      post = FactoryBot.create(:post)
      post.valid?
      expect(post).to be_valid
    end

    it 'is valid when content size is 140' do
      post = FactoryBot.create(:post, :content_size_140)
      post.valid?
      expect(post).to be_valid
    end
  end

  describe 'in invalid case' do
    it 'is invalid without content' do
      post = FactoryBot.build(:post, :without_content)
      post.valid?
      expect(post.errors[:content]).to include "can't be blank"

    end

    it 'is invalid when content size is 141' do
      post = FactoryBot.build(:post, :content_size_141)
      post.valid?
      expect(post.errors[:content]).to include "is too long (maximum is 140 characters)"
    end
  end
end
