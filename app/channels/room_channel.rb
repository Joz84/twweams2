class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    p data
    ActionCable.server.broadcast 'room_channel', {message: data['message']}
    Message.create(content: data['message']#, user_id: cookies.signed[:user_id], channel_id: cookies.signed[:channel_id])
  end
end
