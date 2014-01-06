class Brewery < ActiveRecord::Base

  include TheModule

  attr_accessible :name, :year
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  #validates :name, presence: true
  validates_presence_of :name
  validates_presence_of :year
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                   :only_integer => true }



  validate :year_max_curr_year

  def year_max_curr_year

    if not year <= Time.now.year

      errors.add(:year, "year must be less or equal to current year #{Time.now.year}")


    end

  end


end
