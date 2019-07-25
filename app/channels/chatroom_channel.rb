class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"

    # a default that’s called when a client connects to the channel, usually
    # used to 'subscribe' the client to listen to changes.
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(chatroom_data)
    # custom action which will be used to receive data from its client-side
    #  representation
    ActionCable.server.broadcast "chatroom_channel", message: chatroom_data['message']
  end
end
