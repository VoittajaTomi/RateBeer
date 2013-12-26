class Brewery < ActiveRecord::Base
  attr_accessible :name, :year
  has_many :beers
  has_many :ratings, :through => :beers
  #@beers = Beer.all

  def average_rating

    avgsum = 0
    self.beers.each { |beer| avgsum +=beer.average_rating }
    count = self.beers.count
    return avgsum/count

  end


end
