require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
    [ Place.new( name:"Oljenkorsi", id: 1 ) ]
  	)

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if several are returned by the API, they are all shown on the page" do
  	allow(BeermappingApi).to receive(:places_in).with("kallio").and_return(
    [ Place.new( name:"Pub Porthan", id: 2 ) , Place.new( name:"Las Vegas", id: 3 )  ]
  	)

  	visit places_path
  	fill_in('city', with: 'kallio')
  	click_button "Search"

  	expect(page).to have_content "Pub Porthan"
  	expect(page).to have_content "Las Vegas"
  end
  it "if no bars found returns notification with name of bar" do
  	allow(BeermappingApi).to receive(:places_in).with("hakaniemi").and_return( []
  	)

  	visit places_path
  	fill_in('city', with: 'hakaniemi')
  	click_button "Search"
  	
  	expect(page).to have_content "No locations in hakaniemi"
  end
end