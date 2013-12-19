class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score
  belongs_to :beer

  def to_s
    score.to_s()
  end

end
