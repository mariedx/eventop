require 'time'

class Event < ApplicationRecord
  belongs_to :admin, class_name: "User" #admin
  has_many :attendances
  has_many :participants, through: :attendances #participants

  validates_presence_of :start_date
  validate :start_date_cannot_be_in_the_past
  
  validates :duration, presence: true, numericality: {greater_than: 0}, if: :is_multiple? #multiple de 5, et est strictement positif
  validates :title, presence: true, length: { in: 5..140 } #doit faire au moins 5 caractères et maxi 140 caractères.
  validates :description, presence: true, length: { in: 20..1000 } #doit faire entre 20 et 1000 caractères.
  validates :price, presence: true, :inclusion => 1..1000 #doit être compris entre 1 et 1000.
  validates :location, presence: true

  def is_multiple?
    if duration % 5 != 0
      errors.add(:duration, "must be a multiple of 5") 
    end
  end

  private

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end
end

# errors.add(:start_date, "can't be in the past") unless
# self.start_date < Date.today
# end