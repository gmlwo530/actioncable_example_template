class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_room_#{params[:chat_room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create_message(data)
    current_user.chat_messages.create(body: data["chat_message"], chat_room_id: data["chat_room_id"])
  end
end
