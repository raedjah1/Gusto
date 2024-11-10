# tests for spec/controllers/reviews_controller.rb
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:chef_profile) { create(:chef_profile) }

  before { sign_in user }

  describe "POST #create" do
    it "should create a review" do
      expect {
        post :create, params: { chef_profile_id: chef_profile.id, review: { rating: 5, comments: "Great!" } }
      }.to change(Review, :count).by(1)
    end
  end
end
