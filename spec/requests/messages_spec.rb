require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/messages/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new message" do
      post "/messages", params: { message: { content: "Hello, World!" } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a message" do
      delete "/messages/1"
      expect(response).to have_http_status(:no_content)
    end
  end
end
