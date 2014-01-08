class User < ActiveRecord::Base
  
  include TheModule
  
  attr_accessible :username, :password, :password_confirmation, :admin
  has_secure_password
  
  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  
  validates_uniqueness_of :username
  
  validates_length_of :password, :minimum => 4
  
  validates_length_of :username, :minimum => 3, :maximum => 15
  
  validates_presence_of :password
  
  validate :password_not_all_letters
  
  
  def is_admin?
    admin == true
  end


  
  def favorite_brewery
    
    return nil if ratings.empty?
    result = ratings.group_by { |r| r.beer.brewery }
    Hash[result.map{|brewery, ratings| [brewery, avg(ratings)]}].first.first
    
  end
  
  def favorite_style
    
    return nil if ratings.empty?
    result=ratings.group_by{ |r| r.beer.style }
    Hash[result.map{|tyyli,arvostelut| [tyyli, avg(arvostelut)]}].first.first
    
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end
  
  def average_rating
    avg ratings
  end
  
  def password_not_all_letters
    if not password == nil
      errors.add(:password, "password must be not only letters") if password[/[^a-zA-Z]+/] == nil
    end
  end
  
end
