class User < ActiveRecord::Base

  attr_accessible :name, :username, :password
  validates_uniqueness_of :username

  validates :username, presence: true, length: { maximum: 50 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_one :location

end
