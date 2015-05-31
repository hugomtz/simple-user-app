class Location < ActiveRecord::Base
  attr_accessible :city, :state, :country

  belongs_to :user

  def to_s
    location = Array.new
    location << self.city if self.city
    location << self.state if self.state
    location << self.country if self.country
    location.join(', ')
  end
end
