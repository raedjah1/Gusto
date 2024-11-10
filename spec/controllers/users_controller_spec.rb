# tests for spec/controllers/users_controller.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "PATCH #update" do
    it "should update the user's profile" do
      patch :update, params: { id: user.id, user: { name: "Updated Name" } }
      expect(user.reload.name).to eq("Updated Name")
    end
  end
end
