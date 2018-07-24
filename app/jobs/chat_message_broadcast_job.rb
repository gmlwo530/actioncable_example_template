class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "chat_room_#{chat_message.chat_room.id}",
                                sent_message: render_sent_message(chat_message),
                                received_message: render_received_message(chat_message),
                                user_id: chat_message.user.id
  end

  private

  def render_sent_message(chat_message)
    ChatMessagesController.render partial: 'chat_messages/sent_chat_message', locals: {chat_message: chat_message}
  end

  def render_received_message(chat_message)
    ChatMessagesController.render partial: 'chat_messages/received_chat_message', locals: {chat_message: chat_message}
  end
end
