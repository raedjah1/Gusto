# tests for bookings_controller.rb
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:booking) { create(:booking, user: user) }

  before { sign_in user }

  describe "GET #index" do
    it "should return the user's bookings" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create a new booking" do
        expect {
          post :create, params: { booking: attributes_for(:booking) }
        }.to change(Booking, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create a new booking" do
        post :create, params: { booking: { date: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
