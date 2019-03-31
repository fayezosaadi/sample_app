class User < ApplicationRecord
  # callback method to downcase the email attribute before saving into the db
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  # This one method adds the following functionality:
  # The ability to save a securely hashed password_digest attribute to the database
  # A pair of virtual attributes (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match
  # An authenticate method that returns the user when the password is correct (and false otherwise)
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
