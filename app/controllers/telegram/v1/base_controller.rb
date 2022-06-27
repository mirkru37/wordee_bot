module Telegram
  module V1
    class BaseController < Telegram::Bot::UpdatesController
      def action_missing(*)
        return unless action_type == :command

        respond_with :message,
                     text: I18n.t('bot.common.alert.action_missing', command: action_options[:command])
      end
    end
  end
end
