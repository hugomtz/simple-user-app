class User < ActiveRecord::Base
  attr_accessible :email, :username, :password
  validates_uniqueness_of :username
  has_one :location
end
