class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_messages, dependent: :destroy

  def last_chat(type)
    last_chat = chat_messages.last
    if type == "time"
      last_chat.created_at
    elsif type == "body"
      last_chat.body
    else
      "-"
    end
  end
end
