require 'spec_helper'


describe Beer do
  
  
  it "is not saved with blank name" do
    
    the_beer = Beer.create :name => ""
    
    expect(the_beer.valid?).to be(false)
  
  
  
  end
  
  it "is not saved without a style" do
    
    the_beer = Beer.create :name => "Beer", :style => ""
    
  end
  
  
end
