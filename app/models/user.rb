class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :email, presence: true
  validates :name, length: { maximum: 50 }
  validates :email, length: { maximum: 255 },
          format: { with: VALID_EMAIL_REGEX },
          uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
