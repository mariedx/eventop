class Event < ApplicationRecord
  belongs_to :admin, class_name: "User" #User admin
  has_many :attendances
  has_many :participants, through: :attendances #User participants

  validates :start_date, presence: true, if: :future_date
  
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

  def future_date
    errors.add(:start_date, "Event can't be in the past") unless start_date > DateTime.now
  end
end