class Subscription < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  validates :channel, uniqueness: { scope: :user }

  def count_unread
    self.channel.messages.count - self.opened_messages
  end

end
