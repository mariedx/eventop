require_relative '../mailers/user_mailer'

class User < ApplicationRecord
  after_create :welcome_send
  #has_secure_password

  has_many :attendances
  has_many :events, through: :attendances

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :encrypted_password, presence: true, length: {minimum: 6}
  validates :description, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
