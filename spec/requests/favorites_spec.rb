require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/favorites/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new favorite" do
      post "/favorites", params: { favorite: { item_id: 1 } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a favorite" do
      delete "/favorites/1"
      expect(response).to have_http_status(:no_content)
    end
  end
end
