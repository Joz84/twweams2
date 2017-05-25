class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform data
    ActionCable.server.broadcast 'room_channel', {message: data['message']}
  end
end
