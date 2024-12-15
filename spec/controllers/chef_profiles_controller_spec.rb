require 'rails_helper'

RSpec.describe ChefProfilesController, type: :controller do
  let(:user) { create(:user, role: 'chef') }
  let(:chef_profile) { create(:chef_profile, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'filters chef profiles by search term' do
      create(:chef_profile, specialty: 'Italian')
      create(:chef_profile, specialty: 'French')

      get :index, params: { search: 'Italian' }
      expect(assigns(:chef_profiles).count).to eq(1)
    end

    it 'filters chef profiles by specialty' do
      create(:chef_profile, specialty: 'Italian')
      create(:chef_profile, specialty: 'French')

      get :index, params: { specialty: 'French' }
      expect(assigns(:chef_profiles).count).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: chef_profile.id }
      expect(response).to be_successful
    end

    it 'redirects if chef profile not found' do
      get :show, params: { id: 999 }
      expect(response).to redirect_to(chef_profiles_path)
      expect(flash[:alert]).to eq('Chef profile not found.')
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new chef profile' do
      expect {
        post :create, params: { chef_profile: attributes_for(:chef_profile) }
      }.to change(ChefProfile, :count).by(1)
      expect(response).to redirect_to(ChefProfile.last)
      expect(flash[:notice]).to eq('Your chef profile was successfully created.')
    end

    it 'renders new template on failure' do
      post :create, params: { chef_profile: attributes_for(:chef_profile, bio: nil) }
      expect(response).to render_template(:new)
      expect(flash.now[:alert]).to eq('Failed to create your chef profile. Please fix the errors below.')
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: chef_profile.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the chef profile' do
      patch :update, params: { id: chef_profile.id, chef_profile: { bio: 'Updated bio' } }
      chef_profile.reload
      expect(chef_profile.bio).to eq('Updated bio')
      expect(response).to redirect_to(chef_profile)
      expect(flash[:notice]).to eq('Your chef profile was successfully updated.')
    end

    it 'renders edit template on failure' do
      patch :update, params: { id: chef_profile.id, chef_profile: { bio: nil } }
      expect(response).to render_template(:edit)
      expect(flash.now[:alert]).to eq('Failed to update your chef profile. Please fix the errors below.')
    end
  end
end