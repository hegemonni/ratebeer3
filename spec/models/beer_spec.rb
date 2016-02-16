require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has name and style set properly" do
  	beer = Beer.new name:"Bisse", style:"Lager"

  	beer.name.should == "Bisse"
  	beer.style.should == "Lager"
  end
  		
  it "is not saved without a name or style" do
  	beer = Beer.create 
  	expect(beer).not_to be_valid
  end
end
