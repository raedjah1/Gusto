require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'home/index.html.erb', type: :view do
  include Capybara::RSpecMatchers

  before do
    # Mock any necessary helpers and methods
    allow(view).to receive(:user_signed_in?).and_return(false)
    allow(view).to receive(:current_user).and_return(nil)

    # Stub route helpers
    allow(view).to receive(:chef_profiles_path).and_return('/chef_profiles')
    allow(view).to receive(:new_booking_path).and_return('/bookings/new')
    allow(view).to receive(:new_user_registration_path).and_return('/users/sign_up')

    # Render the view
    render template: 'home/index', layout: 'layouts/application'

    # Debugging output (uncomment to debug rendered output)
    # puts rendered
  end

  it 'displays the features section title' do
    expect(rendered).to have_selector('h2.section-title', text: 'The Gusto Experience')
  end

  it 'includes a link to chef profiles' do
    expect(rendered).to have_link('Meet Our Chefs', href: '/chef_profiles')
  end

  it 'includes a link to start a new booking' do
    expect(rendered).to have_link('Start Booking', href: '/bookings/new')
  end

  it 'includes a call to action section' do
    expect(rendered).to have_selector('.cta-section')
    expect(rendered).to have_link('Get Started Today', href: '/users/sign_up')
  end

  it 'displays the feature cards' do
    expect(rendered).to have_selector('.feature-card', count: 3)
    expect(rendered).to have_selector('.feature-card .feature-icon')
  end

  it 'renders the search form with the correct attributes' do
    expect(rendered).to have_selector('form.search-form[action="/chef_profiles"]')
    expect(rendered).to have_selector('input.search-input[placeholder="Search cuisines, locations, or chef specialties..."]')
    expect(rendered).to have_button('Find Your Chef')
  end
end
