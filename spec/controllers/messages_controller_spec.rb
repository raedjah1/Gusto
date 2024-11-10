# tests for spec/controllers/messages_controller.rb
require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "POST #create" do
    it "should create a message" do
      expect {
        post :create, params: { message: { receiver_id: create(:user).id, content: "Hello" } }
      }.to change(Message, :count).by(1)
    end
  end
end
