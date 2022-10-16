require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    context "正常系" do
      it "正常なパラメータで保存できることの確認" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end

      it "名前が20文字の場合" do
        user = FactoryBot.build(:user, :name_size_20)
        expect(user).to be_valid
      end
    end

    context "異常系" do
      it "nameが空の場合" do
        user = FactoryBot.build(:user, :without_name)
        user.valid?
        expect(user.errors[:name]).to include "を入力してください"
      end

      it "nameが重複される場合" do
        user = FactoryBot.create(:user, name: "test")
        other_user = FactoryBot.build(:user, name: "test")
        expect(user).to be_valid
        other_user.valid?
        expect(other_user.errors[:name]).to include "はすでに存在します"
      end

      context "nameにアルファベット以外の文字列が含まれる場合" do
        it '数字が含まれる場合' do
          user = FactoryBot.build(:user, :name_include_num)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end

        it '日本語の場合' do
          user = FactoryBot.build(:user, :name_japanese)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end
      end

      context "nameにスペースが含まれる場合" do
        it '半角スペースが含まれる場合' do
          user = FactoryBot.build(:user, :name_include_half_space)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end

        it "全角スペースが含まれる場合" do
          user = FactoryBot.build(:user, :name_include_full_space)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end
      end

      it "nameが21文字以上の場合" do
        user = FactoryBot.build(:user, :name_size_21)
        user.valid?
        expect(user.errors[:name]).to include "は20文字以内で入力してください"
      end
    end
  end

  describe "#update" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "正常系" do
      it "正常なパラメータで保存できることの確認" do
        @user.name = Faker::Base.regexify("[a-zA-Z]{10}")
        @user.profile = Faker::Lorem.characters(number: 20)
        expect(@user).to be_valid
      end

      it "profileが200文字の場合" do
        @user.profile = Faker::Lorem.characters(number: 200)
        expect(@user).to be_valid
      end

      it "blog_urlがURL形式の場合" do
        @user.blog_url = Faker::Internet.url(host: 'faker')
        expect(@user).to be_valid
      end
    end

    context "異常系" do
      it "nameが空の場合" do
        @user.name = ""
        @user.valid?
        expect(@user.errors[:name]).to include "を入力してください"
      end

      context "nameにアルファベット以外の文字列が含まれる場合" do
        it '数字が含まれる場合' do
          @user.name = Faker::Lorem.characters(min_alpha: 1, min_numeric: 1)
          @user.valid?
          expect(@user.errors[:name]).to include "はアルファベットのみが使えます"
        end

        it '日本語の場合' do
          @user.name = Faker::Name.first_name
          @user.valid?
          expect(@user.errors[:name]).to include "はアルファベットのみが使えます"
        end
      end

      context "nameにスペースが含まれる場合" do
        it '半角スペースが含まれる場合' do
          user = FactoryBot.build(:user, :name_include_half_space)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end

        it "全角スペースが含まれる場合" do
          user = FactoryBot.build(:user, :name_include_full_space)
          user.valid?
          expect(user.errors[:name]).to include "はアルファベットのみが使えます"
        end
      end

      it "nameが21文字以上の場合" do
        @user.name = Faker::Base.regexify("[a-zA-Z]{21}")
        @user.valid?
        expect(@user.errors[:name]).to include "は20文字以内で入力してください"
      end

      it "profileが201文字以上の場合" do
        @user.profile = Faker::Lorem.characters(number: 201)
        @user.valid?
        expect(@user.errors[:profile]).to include "は200文字以内で入力してください"
      end

      it "blog_urlがURL形式以外の場合" do
        @user.blog_url = Faker::Lorem.characters(number: 10)
        @user.valid?
        expect(@user.errors[:blog_url]).to include "は不正な値です"
      end
    end
  end
end
