class ChatController < ApplicationController
  def show
    @messages = ChatMessage.all
  end
end
