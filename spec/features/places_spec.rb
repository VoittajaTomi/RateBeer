require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi") ] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  
  it "if more than one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi"), Place.new(:name => "Kapusiini"), Place.new(:name => "Unicafe") ] )
  #  BeermappingAPI.stub(:places_in).with("kumpula").and_return( [   ] )
    
    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    #save_and_open_page
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kapusiini"
    expect(page).to have_content "Unicafe"
  end

  it "if no places are found" do

    visit places_path
    fill_in('city', :with => '@@@@')
    click_button "Search"

    #save_and_open_page
    expect(page).to have_content "No locations in @@@@"

  end
  
  
  
end