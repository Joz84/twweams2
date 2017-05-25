class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  # after_create_commit { MessageBroadcastJob.perform_now self }
end
