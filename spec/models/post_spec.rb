require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#validation' do
    context 'in valid case' do
      before do
        @user = FactoryBot.create(:user)
      end
      it 'is valid with content' do
        post = FactoryBot.create(:post, user: @user)
        post.valid?
        expect(post).to be_valid
      end

      it 'is valid when content size is 140' do
        post = FactoryBot.create(:post, :content_size_140, user: @user)
        post.valid?
        expect(post).to be_valid
      end
    end

    context 'in invalid case' do
      it 'is invalid without content' do
        post = FactoryBot.build(:post, :without_content)
        post.valid?
        expect(post.errors[:content]).to include "を入力してください"
      end

      it 'is invalid when content size is 141' do
        post = FactoryBot.build(:post, :content_size_141)
        post.valid?
        expect(post.errors[:content]).to include "は140文字以内で入力してください"
      end
    end
  end

  describe '#scope' do
    context 'recent' do
      it 'returns latest post' do
        post = FactoryBot.build(:post)
        FactoryBot.build(:post, :post_day_ago)
        expect(post).to eq post
      end
    end
  end
end
