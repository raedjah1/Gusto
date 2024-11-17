require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/users/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new user" do
      post "/users", params: { user: { name: "John Doe", email: "john@example.com", password: "password" } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a user" do
      delete "/users/1"
      expect(response).to have_http_status(:no_content)
    end
  end
end
