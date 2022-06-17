module Telegram
  module V1
    class PrivateChatController < BaseController
      include Telegram::Bot::UpdatesController::MessageContext

      def start!(*)
        Telegram::V1::Chats::Register.call(chat:)
        Telegram::V1::Bots::Start.call(bot:, chat:)
      end
    end
  end
end
