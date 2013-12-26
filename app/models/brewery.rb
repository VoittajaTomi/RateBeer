class Brewery < ActiveRecord::Base
  attr_accessible :name, :year
  has_many :beers

  #@beers = Beer.all

  def average_rating

    avgsum = 0
    self.beers.each { |beer| avgsum +=beer.average_rating }
    return avgsum/beers.count

  end


end
