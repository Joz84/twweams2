class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, id)
    ActionCable.server.broadcast "room_channel_#{id}", render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: '/messages/shared/message', locals: {message: message}
  end
end
