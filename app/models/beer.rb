class Beer < ActiveRecord::Base

  include TheModule

  attr_accessible :brewery_id, :name, :style
  belongs_to :brewery
  has_many :ratings, :dependent=>:destroy

#  has_many :users, :through => :ratings

  has_many :raters, :through => :ratings, :source => :user


  validates :name, length: { minimum: 1 }, presence: true

  def to_s

    name + " brewed by " + brewery.name

  end
  
  def average_rating
    
    avg ratings
    
  end

end
