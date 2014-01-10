class Style < ActiveRecord::Base
  attr_accessible :desc, :name

  has_many :beers
  
  #belongs_to :style
  
  def to_s
    
    name
    
  end
end
