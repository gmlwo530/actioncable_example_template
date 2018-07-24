class ChatMessage < ApplicationRecord
  default_scope { order('created_at') }

  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true

  after_create_commit {ChatMessageBroadcastJob.perform_later(self) }
end
