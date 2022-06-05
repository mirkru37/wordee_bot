module Telegram
  module V1
    module WebhooksRouter
      module_function

      def dispatch(bot, chat)
        chat = chat.with_indifferent_access
        Telegram::V1::Common::RouteManagerService.call(chat:)[:controller].dispatch(bot, chat)
      end
    end
  end
end
