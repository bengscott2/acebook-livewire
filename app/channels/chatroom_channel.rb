class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(chatroom_data)
    ActionCable.server.broadcast(
      "chatroom_channel",
      message: chatroom_data['message'])
  end
end
