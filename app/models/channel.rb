class Channel < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :users, through: :subscriptions

  def one_to_one?
    subscriptions.size == 2 && !name
  end

  def init(selected_users, current_user)
    selected_users.each do |user|
      admin = one_to_one? || (user == current_user)
      Subscription.create(channel: self, user: user, admin: admin)
    end
  end

  def default_name(current_user)
    if name && !name.strip.empty?
      name
    else
      default_name = users.map(&:alias)
      default_name.delete(current_user.alias)
      default_name[0...2].join(", ")
    end
  end

end
