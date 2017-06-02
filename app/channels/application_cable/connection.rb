module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :current_channel

    def connect
      self.current_user = find_current_user
      self.current_channel = find_current_channel
    end

    private

    def find_current_user
      if connected_user = User.find_by(id: cookies.signed[:user_id])
        connected_user
      else
        reject_unauthorized_connection
      end
    end

    def find_current_channel
      # Tried to connect from ApplicationCable::Channel if not explicitely specified
      if connected_channel = ApplicationRecord::Channel.find_by(id: cookies.signed[:channel_id])
        connected_channel
      else
        reject_unauthorized_connection
      end
    end

  end
end
