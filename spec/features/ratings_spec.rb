require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  it "and user ratings are shown on user page" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"

    visit user_path(user)
    @ratings = Rating.all

    user.ratings.each do |rating|
      expect(page).to have_content rating.score
    end
  end
  it "when user removes rating it is removed from db" do
    visit user_path(user)
    @ratings = Rating.all

    user.ratings.each do |rating|
      within(".rating") do
        click_on("delete")
      end
    end
  end
  describe "ratings page" do
    before :each do
      visit new_rating_path
      select('iso 3', from:'rating[beer_id]')
      fill_in('rating[score]', with:'15')
      click_button "Create Rating"
    end

    it "ratings page lists the ratings and their amount " do
      visit ratings_path

      expect(page).to have_content "Number of ratings #{Rating.count}"
    end
    it "and their amount" do
      visit ratings_path
      @ratings = Rating.all

      @ratings.each do |rating|
          expect(page).to have_content rating.score
      end
    end
  end
end