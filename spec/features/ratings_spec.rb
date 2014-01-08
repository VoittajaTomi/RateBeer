require 'spec_helper'

describe "Rating" do
  
  include OwnTestHelper
  
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
sign_in 'Pekka', 'foobar1'
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  
  it "given ratings are shown on ratings page" do
  
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)    
    visit new_rating_path
    select(beer2.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')    
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(1).to(2)

    expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(1)
    expect(beer2.ratings.count).to eq(1)
    visit ratings_path
    #save_and_open_page
    
    
  end
  
  it "given ratings are shown on user page" do

    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)    
    visit new_rating_path
    select(beer2.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')    
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(1).to(2)
    
    visit('/users/1')
    
    expect(page).to have_content "iso 3: 15"
    expect(page).to have_content "Karhu: 15"
    
    #save_and_open_page
    
  end
  
  
  it "can be removed" do

    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)      
   
    
    visit('/users/1')
    #page.evaluate_script('window.confirm = function() { return true; }')
    click_link("delete")
    #click_button("OK")
    
    expect(user.ratings.count).to eq(0)
    
    
  end
  
end