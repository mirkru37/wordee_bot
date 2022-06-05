module Telegram
  module V1
    module Common
      class RouteManagerService < BaseService
        BOT_COMMAND = 'bot_command'.freeze
        CONTROLLERS = [
          Telegram::V1::ChatController
        ].freeze
        DEFAULT_CONTROLLER = Telegram::V1::ChatController

        logic do
          step :find_entity
          step :parse_command
          step :find_controller
          fail :default_controller
        end

        private

        def find_entity(chat:, **)
          ctx[:entity] = chat.dig(:message, :entities)&.find { |entity| entity[:type] == BOT_COMMAND }
        end

        def parse_command(chat:, **)
          offset = ctx[:entity][:offset]
          length = ctx[:entity][:length]
          comd_range = (offset.next..(offset + length.pred))
          ctx[:command] = chat.dig(:message, :text)[comd_range].to_sym
        end

        def find_controller(**)
          ctx[:controller] = CONTROLLERS.find { |controller| controller.match_command?(ctx[:command]) }
        end

        def default_controller(**)
          ctx[:controller] = DEFAULT_CONTROLLER
        end
      end
    end
  end
end
