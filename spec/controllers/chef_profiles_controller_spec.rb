# tests for spec/controllers/chef_profiles_controller.rb
require 'rails_helper'

RSpec.describe ChefProfilesController, type: :controller do
  describe "GET #index" do
    it "should list all chef profiles" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when the user is logged in" do
      let(:user) { create(:user) }

      before { sign_in user }

      it "should create a chef profile" do
        expect {
          post :create, params: { chef_profile: attributes_for(:chef_profile) }
        }.to change(ChefProfile, :count).by(1)
      end
    end
  end
end
