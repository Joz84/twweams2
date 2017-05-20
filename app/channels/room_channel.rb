class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
    # Message.create(content: data['message'], user_id: current_user.id, channel_id: params[:id])
    ActionCable.server.broadcast 'room_channel', {message: data['message']}
    # Message.create! content: data['message'], channel_id: @channel
  end
end
