class ChatController < ApplicationController
  def show

    @messages = Chat_message.all
  end
end
