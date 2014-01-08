        

    require 'spec_helper'
    
    def create_beer_with_rating(score,  user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
      beer
    end
    
    def create_beer_with_rating_and_style(score, style, user)
      beer = FactoryGirl.create(:beer, :style => style)
      FactoryGirl.create(:rating, :score => score ,:beer => beer, :user => user)
      beer
    end
    
    
    def create_beers_with_ratings(*scores, user)
      scores.each do |score|
        create_beer_with_rating score, user
      end
    end
    
    describe User do
      

      
      
      it "is the one with highest rating if several rated" do
        user = FactoryGirl.create(:user)
        create_beer_with_rating 10, user
        best = create_beer_with_rating 25, user
        create_beer_with_rating 7, user
        
        expect(user.favorite_beer).to eq(best)
      end
      
      
      it "is the only rated if only one rating" do
        user = FactoryGirl.create(:user) 
        beer = FactoryGirl.create(:beer)
        rating = FactoryGirl.create(:rating, :beer => beer, :user => user)
        
        expect(user.favorite_beer).to eq(beer)
      end
      
      describe "favorite beer" do
        let(:user){FactoryGirl.create(:user) }
        
        it "has method for determining one" do
          user.should respond_to :favorite_beer
        end
        
        it "without ratings does not have one" do
          expect(user.favorite_beer).to eq(nil)
        end
        
        it "is the only rated if only one rating" do
          beer = create_beer_with_rating 10, user
          
          expect(user.favorite_beer).to eq(beer)
        end
        
        it "is the one with highest rating if several rated" do
          create_beers_with_ratings 10, 20, 15, 7, 9, user
          best = create_beer_with_rating 25, user
          
          expect(user.favorite_beer).to eq(best)
        end
        
        
      end
      
      describe "favorite style" do
        
        let(:user){FactoryGirl.create(:user)}
        
        it "has method for determining one" do
          user.should respond_to :favorite_style
        end
        
        it "without ratings does not have one" do
          expect(user.favorite_style).to eq(nil)
        end
        
        it "is the only rated if only one rating" do
          beer = create_beer_with_rating_and_style 10, "Weizen", user
          expect(user.favorite_style).to eq("Weizen")
          
          
        end
        
        it "is the one with highest rating if several rated" do
          beer1 = create_beer_with_rating_and_style 10, "Weizen", user
          beer2 = create_beer_with_rating_and_style 15, "Weizen", user
          beer3 = create_beer_with_rating_and_style 10, "Lager", user
          beer4 = create_beer_with_rating_and_style 14, "Lager", user
          
          expect(user.favorite_style).to eq("Weizen")
        end
        
        
      end
      
      describe "favorite brewery" do
        
        let(:user){FactoryGirl.create(:user)}
        
        it "has method for determining one" do
          user.should respond_to :favorite_brewery
        end
        
        it "without ratings does not have one" do
          
          expect(user.favorite_brewery).to eq(nil)
        end
        
        it "is the only rated if only one rating" do
          
          brewery1 = FactoryGirl.create(:brewery)
          beer1 = FactoryGirl.create(:beer, brewery: brewery1)
          FactoryGirl.create(:rating, :score => 15 ,:beer => beer1, :user => user)
          
          expect(user.favorite_brewery.name).to eq("anonymous")
          
        end
        
        it "is the one with highest rating if several rated" do
          
          brewery1 = FactoryGirl.create(:brewery)
          brewery2 = FactoryGirl.create(:brewery, :name => "aa")
          #           
          beer1 = FactoryGirl.create(:beer, brewery: brewery1)
          FactoryGirl.create(:rating, :score => 15 ,:beer => beer1, :user => user)
          beer2 = FactoryGirl.create(:beer, brewery: brewery1)
          FactoryGirl.create(:rating, :score => 15, :beer => beer2, :user => user)
          beer3 = FactoryGirl.create(:beer, brewery: brewery2)
          FactoryGirl.create(:rating, :score => 15, :beer => beer3, :user => user)
          beer4 = FactoryGirl.create(:beer, brewery: brewery2)
          FactoryGirl.create(:rating, :score => 14, :beer => beer4, :user => user)
          
          expect(user.favorite_brewery.name).to eq("anonymous")
          
        end        
        
        
      end
      
      #Lisää luokalle User testit jotka varmistavat, että liian lyhyen tai pelkästään kirjaimista muodostetun salasanan omaavan käyttäjän luominen create-metodilla ei tallenna olioa tietokantaan,
      #ja että luodun olion validointi ei ole onnistunut
      
      it "is not saved without a too short password" do
        
        user = User.create :username => "Pekka", :password => "a1c", :password_confirmation => "a1c"
        
        expect(user.valid?).to be(false)
        expect(User.count).to eq(0)
        
        
      end  
      
      it "is not saved with letters-only password" do
        
        user = User.create :username => "Pekka", :password => "abca", :password_confirmation => "abca"
        
        expect(user.valid?).to be(false)
        expect(User.count).to eq(0)
        
        
      end  
      
    end
    
    