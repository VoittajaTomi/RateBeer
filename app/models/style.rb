class Style < ActiveRecord::Base

  include TheModule

  attr_accessible :desc, :name

  has_many :beers

  has_many :ratings, :through => :beers

  
  def self.top(n)
    return Style.all.sort_by{ |b| -b.average_rating }.first(n)
  end
  
  def average_rating
    avg ratings
  end
  
  def to_s
    
    name
    
  end
end
