class User < ActiveRecord::Base
  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/

  attr_accessible :name, :username, :password
  validates_uniqueness_of :username
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :username, presence: true, length: { minimum: 3, maximum: 30 }
  validates_format_of :username, :with => VALID_USERNAME_REGEX
  validates :password, length: { minimum: 6 }
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  has_secure_password

  has_one :location
=begin
  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
=end
end
