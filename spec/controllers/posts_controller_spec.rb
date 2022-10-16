require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it 'responds successfully' do
        get :index
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      it 'returns a 302 response' do
        get :index
        expect(response).to have_http_status "302"
      end

      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  # describe "#create" do
  #   context "with valid attributes" do
  #     before do
  #       @posts = Post.recent.all
  #     end
  #     it 'adds a post' do
  #       post_params = FactoryBot.attributes_for(:post)
  #       expect {
  #         post :create, params: { post: post_params }
  #       }.to change(@posts, :count).by(1)
  #     end
  #
  #     it 'does not add a post' do
  #       post_params = FactoryBot.attributes_for(:post, :without_content)
  #       expect {
  #         post :create, params: { post: post_params }
  #       }.to change(@posts, :count).by(0)
  #     end
  #   end
  # end
end
