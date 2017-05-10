class Subscription < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validates :channel, uniqueness: { scope: :user }

end
