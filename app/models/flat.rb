class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch

  pg_search_scope :search_by_adress,
    against: [ :adress ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  pg_search_scope :search_by_capacity,
    against: [ :capacity ],
    using: {
      tsearch: { prefix: false }
    }
end
