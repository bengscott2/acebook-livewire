class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      'chatroom_channel',
      message: render_message(message)
    )
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(
      partial: 'chat/_chat_message',
      locals: { message: message }
      )
  end
end
