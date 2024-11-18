require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "renders the home page" do
    render
    expect(rendered).to have_content('Welcome to our website')
  end

  it "displays a call to action" do
    render
    expect(rendered).to have_content('Explore Our Services')
  end

  it "includes a link to the chef profiles" do
    render
    expect(rendered).to have_link('Meet Our Chefs', href: chef_profiles_path)
  end

  it "includes a link to the bookings page" do
    render
    expect(rendered).to have_link('Book a Table', href: bookings_path)
  end

  it "includes a link to the search page" do
    render
    expect(rendered).to have_link('Search for Recipes', href: searches_path)
  end

  it "includes a link to the reviews page" do
    render
    expect(rendered).to have_link('Read Reviews', href: reviews_path)
  end

  it "includes a link to the favorites page" do
    render
    expect(rendered).to have_link('View Favorites', href: favorites_path)
  end
end
