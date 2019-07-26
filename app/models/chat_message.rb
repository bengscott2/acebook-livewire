class ChatMessage < ApplicationRecord
  # the after_create_commit hook tells rails to execute
  # this job after the message is saved in the db 
  after_create_commit { ChatMessageBroadcastJob.perform_later self }
end
