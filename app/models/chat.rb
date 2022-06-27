class Chat < ApplicationRecord
  enum :chat_type, {
    private: 0
  }, prefix: true

  validates :chat_type, presence: true
end
