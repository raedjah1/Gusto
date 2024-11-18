# spec/requests/favorites_spec.rb
require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { { Authorization: "Bearer #{user.auth_token}" } }
  let(:favorite) { create(:favorite, user: user) }

  describe "GET /index" do
    it "returns http success" do
      get favorites_path, headers: auth_headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new favorite" do
      post favorites_path, params: { favorite: { user_id: user.id, menu_item_id: create(:menu_item).id } }, headers: auth_headers
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a favorite" do
      delete favorite_path(favorite), headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
