class Beer < ActiveRecord::Base

  include TheModule

  attr_accessible :brewery_id, :name, :style_id, :style
  belongs_to :style
  belongs_to :brewery
  has_many :ratings, :dependent=>:destroy
  

  has_many :raters, :through => :ratings, :source => :user


  validates :name, length: { minimum: 1 }, presence: true

  def self.top(n)
    return all.sort_by{ |b| -b.average_rating }.first(n)
  end
  
  def to_s

    name + " brewed by " + brewery.name

  end
  
  def average_rating
    
    avg ratings
    
  end

end
