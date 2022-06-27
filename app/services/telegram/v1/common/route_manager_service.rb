module Telegram
  module V1
    module Common
      class RouteManagerService < BaseService
        BOT_COMMAND = 'bot_command'.freeze
        PRIVATE_CHAT = :private
        PRIVATE_CHAT_CONTROLLER = Telegram::V1::PrivateChatController
        DEFAULT_CONTROLLER = Telegram::V1::BaseController

        logic do
          step :parse_type
          step :find_controller
        end

        private

        def parse_type(chat:, **)
          ctx[:chat_type] = chat.dig(:message, :chat, :type).to_sym
        end

        def find_controller(**)
          ctx[:controller] = if ctx[:chat_type] == PRIVATE_CHAT
                               PRIVATE_CHAT_CONTROLLER
                             else
                               DEFAULT_CONTROLLER
                             end
        end
      end
    end
  end
end
