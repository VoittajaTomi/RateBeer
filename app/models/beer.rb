class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style
  belongs_to :brewery
  has_many :ratings

  def average_rating

    sum = ratings.inject(0.0) { |result, element| result + element.score }
    return sum / ratings.count
	
  end

end
