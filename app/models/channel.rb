class Channel < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :name, presence: true
  validates :name, uniqueness: true

  def one_to_one?
    subscriptions.size == 2 && users.map { |u| u.alias }.include?(name)
  end

  def done
    messages.each { |message| message.update(done = true) }
  end

  def done?
    messages.last
  end

  def init(selected_users, current_user)
    selected_users.each do |user|
      admin = one_to_one? || (user == current_user)
      Subscription.create(channel: self, user: user, admin: admin)
    end
  end

end
