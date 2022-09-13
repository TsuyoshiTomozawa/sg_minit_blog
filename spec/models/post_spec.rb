require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'valid case' do
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

  describe 'invalid case' do
    it 'is invalid without content' do
      post = FactoryBot.create(:post, :without_content)
      post.valid?
      expect(post).to_not be_valid

    end

    it 'is invalid when content size is 141' do
      post = FactoryBot.create(:post, :content_size_141)
      post.valid?
      expect(post).to_not be_valid
    end
  end
end
