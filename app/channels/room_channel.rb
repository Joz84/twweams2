class RoomChannel < ApplicationCable::Channel
  def subscribed
    # current_channel comes from connection.rb
    stream_from "room_channel_#{current_channel.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    # data is a hash here, serialized from a JSON coming from the view.
    p data
    Message.create(content: data['message'], user_id: current_user.id, channel_id: current_channel.id)
  end
end
