class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  validates :start_date, presence: true
  validates :end_date, presence: true

  include PgSearch

  pg_search_scope :search_by_start_date,
    against: [ :start_date ],
    using: {
      tsearch: { prefix: false }
    }

  pg_search_scope :search_by_end_date,
    against: [ :end_date ],
    using: {
      tsearch: { prefix: false }
    }

end
