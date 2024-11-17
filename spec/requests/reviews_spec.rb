require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/reviews/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new review" do
      post "/reviews", params: { review: { content: "Great product!" } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a review" do
      delete "/reviews/1"
      expect(response).to have_http_status(:no_content)
    end
  end
end
