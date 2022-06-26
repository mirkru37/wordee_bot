module Telegram
  module V1
    class PrivateChatController < BaseController
      include Telegram::Bot::UpdatesController::MessageContext

      def start!(*)
        Telegram::V1::Chats::Register.call(id: chat[:id], chat_type: chat[:type])
        respond_with :message,
                     text: I18n.t('bot.commands.start', user: chat[:username] || I18n.t('nicknames.default_user'))
      end
    end
  end
end
