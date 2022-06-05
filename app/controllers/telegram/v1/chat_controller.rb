module Telegram
  module V1
    class ChatController < BaseController
      include Telegram::Bot::UpdatesController::MessageContext

      def start!(word = nil, *_other)
        word ||= 'Empty start'
        respond_with :message, text: word
      end

      def message(message)
        save_context :feel_sorry
        reply_with :message, text: "#{message['text']}, #{chat['first_name']}"
      end

      def feel_sorry(*words)
        words ||= %w[1 2]
        respond_with :message, text: words.join('-')
      end

      class << self
        def match_command?(command)
          %i[start].include? command
        end
      end
    end
  end
end
