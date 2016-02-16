require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
    @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
  end

  describe "beers created" do
    it "have a name" do
      visit new_beer_path
      fill_in('beer_name', with:'VMP')
      click_on('Create Beer')

      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'Beer was successfully created.'
      expect(page).to have_content 'Listing Beers'
    end

    it "are not saved if name nil" do
      visit new_beer_path
      fill_in('beer_name', with:'')
      click_on('Create Beer')

      expect(current_path).to eq(beers_path)
      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end

