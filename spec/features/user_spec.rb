require 'spec_helper'

describe "User" do
  
  include OwnTestHelper
  
  
  #let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  #let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  #let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
    #let!(:user) { FactoryGirl.create :user }
    
  before :each do
    FactoryGirl.create :user
    #FactoryGirl.create :brewery
  end
  
  describe "users list" do
    
    it "test user is listed" do
      
      visit users_path
      #save_and_open_page
      expect(page).to have_content "Pekka"
      
    end
    
    
  end
  
  describe "favorites" do
    
    it "favorite beer style is displayed" do
         #sign_in '1Pekka', 'foobar1'

      
      visit "/users/1"
      save_and_open_page
      
    end
    
  end
  
  
  
  describe "who has signed up" do
    
    it "can sign in with right credentials" do
      
      sign_in 'Pekka', 'foobar1'
      
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    
    # ...
    
    it "is redirected back to sign in form if wrong credentials given" do
      
      sign_in 'Pekka', 'wrong'
      
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
    
    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', :with => 'Brian')
      fill_in('user_password', :with => 'secret55')
      fill_in('user_password_confirmation', :with => 'secret55')
      
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end
  
end