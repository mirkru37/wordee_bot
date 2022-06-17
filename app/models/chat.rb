class Chat < ApplicationRecord
  enum :chat_type, {
    private: 0, group: 1
  }, prefix: true

  validates :chat_type, presence: true
end
