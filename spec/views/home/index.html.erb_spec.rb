require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  it 'displays the features section title' do
    render
    expect(rendered).to have_selector('h2.section-title', text: 'The Gusto Experience')
  end

  it 'includes a link to chef profiles' do
    render
    expect(rendered).to have_link('Meet Our Chefs', href: chef_profiles_path)
  end

  it 'includes a link to new booking' do
    render
    expect(rendered).to have_link('Start Booking', href: new_booking_path)
  end

  it 'includes a call to action section' do
    render
    expect(rendered).to have_selector('.cta-section')
    expect(rendered).to have_link('Get Started Today', href: new_user_registration_path)
  end

  it 'displays the feature cards' do
    render
    expect(rendered).to have_selector('.feature-card', count: 3)
    expect(rendered).to have_selector('.feature-card .feature-icon')
    expect(rendered).to have_link('Meet Our Chefs', href: chef_profiles_path)
  end
end
