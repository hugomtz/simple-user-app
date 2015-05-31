class User < ActiveRecord::Base
  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/

  attr_accessible :name, :username, :password, :password_confirmation, :avatar_image_id
  validates_uniqueness_of :username
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :username, presence: true, length: { minimum: 3, maximum: 30 }
  validates_format_of :username, :with => VALID_USERNAME_REGEX
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates_confirmation_of :password

  has_secure_password

  extend FriendlyId
  friendly_id :username , :use => :slugged

  has_one :location

  max_paginates_per 5

  def self.generate_cloudinary_signature(timestamp)
    transformation = image_transformation
    Cloudinary::Utils.api_sign_request({timestamp: timestamp, transformation: transformation, format: "png"}, Cloudinary.config.api_secret)
  end

  def self.image_transformation
    transformation = "w_200,h_200,c_fill,g_face,r_max"
  end
end
