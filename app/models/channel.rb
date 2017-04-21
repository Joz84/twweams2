class Channel < ApplicationRecord
  has_many :subscriptions
  has_many :messages
  has_many :users, through: :subscriptions

  validates :name, presence: true
  validates :name, uniqueness: true

end
