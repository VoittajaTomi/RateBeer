require 'spec_helper'

describe "Beer" do
  
  include OwnTestHelper
  
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
#  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
#  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
sign_in 'Pekka', 'foobar1'
  end

  it "can be added to system" do
    
    #visit beers_path
    #save_and_open_page
    
    visit new_beer_path
    fill_in('beer[name]', :with => 'Grylls')
    save_and_open_page
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1) 
    
    
    
    #select(beer1.to_s, :from => 'rating[beer_id]')
    #fill_in('rating[score]', :with => '15')


    #expect(user.ratings.count).to eq(1)

  end
  

  
end