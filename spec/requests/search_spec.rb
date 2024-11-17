require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/search/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new search" do
      post "/searches", params: { search: { query: "example query" } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/searches"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a search" do
      delete "/searches/1"
      expect(response).to have_http_status(:no_content)
    end
  end
end
