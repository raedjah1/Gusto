require 'rails_helper'

RSpec.describe "search/show.html.erb", type: :view do
  context "when there are search results" do
    before do
      @search_results = [
        double("Result", 
          title: "Test Result",
          description: "Test description",
          class: double(name: "TestClass"),
          created_at: Time.current,
          respond_to?: true
        )
      ]
      assign(:search_results, @search_results)
      assign(:q, "test query")
    end

    it "renders the search results page" do
      render
      expect(rendered).to match(/Search Results/)
      expect(rendered).to match(/Results for: test query/)
    end

    it "displays search result details" do
      render
      expect(rendered).to have_selector('.result-item')
      expect(rendered).to have_selector('.result-type', text: 'TestClass')
      expect(rendered).to have_selector('.result-excerpt', text: 'Test description')
      expect(rendered).to have_selector('.result-date')
    end

    it "handles missing description gracefully" do
      # Set description to nil to simulate a missing description
      @search_results.first.description = nil
      render
      expect(rendered).to have_selector('.result-item')
      expect(rendered).to have_content("No description available.")
    end
  end

  context "when there are no search results" do
    before do
      assign(:search_results, [])
      assign(:q, "no results query")
    end

    it "displays no results message" do
      render
      expect(rendered).to have_selector('.no-results')
      expect(rendered).to have_content('No Results Found')
      expect(rendered).to have_content('Your search "no results query" did not match any records')
    end

    it "includes helpful suggestions" do
      render
      expect(rendered).to have_content('Checking your spelling')
      expect(rendered).to have_content('Using more general keywords')
      expect(rendered).to have_content('Using fewer keywords')
    end

    it "includes navigation links" do
      render
      expect(rendered).to have_link('Home', href: root_path)
      expect(rendered).to have_link('New Search', href: search_path)
    end
  end
end
