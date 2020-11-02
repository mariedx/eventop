class Event < ApplicationRecord
  belongs_to :user #admin
  has_many :attendances
  has_many :users, through: :attendances #participants

  validates :start_date, presence: true #et il est impossible de créer ou modifier un événement dans le passé.
  validate :expiration_date_cannot_be_in_the_past 

  validates :duration, presence: true, numericality: {only_integer: true, greater_than: 0} #le nombre de minutes doit être un multiple de 5, et est strictement positif
  validate :duration
  validate :multiple

  validates :title, presence: true, length: { in: 5..140 } #doit faire au moins 5 caractères et maxi 140 caractères.

  validates :description, presence: true, length: { in: 20..1000 } #doit faire entre 20 et 1000 caractères.

  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000} #doit être compris entre 1 et 1000. (pas d'événement gratuit pour cette première version de l'application)
  
  validates :location, presence: true

  def multiple
    0.step(25,5).to_a
  end

  def duration
    self.start_date - self.end_date
  end

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
