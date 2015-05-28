class User < ActiveRecord::Base
  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/

  attr_accessible :name, :username, :password, :password_confirmation
  validates_uniqueness_of :username
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :username, presence: true, length: { minimum: 3, maximum: 30 }
  validates_format_of :username, :with => VALID_USERNAME_REGEX
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password

  has_secure_password

  extend FriendlyId
  friendly_id :username , :use => :slugged

  has_one :location
end
