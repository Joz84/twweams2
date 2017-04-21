class Subscription < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  def self.init(channel, users, current_user)
    admin = ( users.size == 2 )
    users.each { |user| create(channel: channel, user: user, admin: admin) }
    find_by(user: current_user).admin = true
  end
end
