class Subscription < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  belongs_to :last_message, class_name: :Message, :foreign_key => "message_id"
  validates :channel, uniqueness: { scope: :user }

  def new_messages
    request_messages(">")
  end

  def opened_messages
    request_messages("<=")
  end

  def new_messages_limit
    if !channel.messages.empty? && channel.messages.last.user == user
      channel.messages.count
    else
      opened_messages
    end
  end

  private

  def request_messages(sign)
    channel.messages
           .where("id #{sign} ?", (last_message ? last_message : 0))
           .count
  end

end
