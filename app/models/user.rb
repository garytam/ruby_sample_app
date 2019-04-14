class User < ApplicationRecord

  attr_accessor :password_digest, :password_confirmation

  before_create :set_password_update_date

  before_update :update_password_update_date

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, length: {maximum: 100},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false}

  has_secure_password

  validates :password_digest, presence: true, length: { minimum: 6}

  def set_password_update_date
    self.password_change_date = Time.now
  end

  def update_password_update_date
    if self.password_digest_changed?
      self.password_change_date = Time.now
    end
  end
end
