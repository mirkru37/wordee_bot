module Telegram
  module V1
    module Chats
      class Register < BaseService
        logic do
          step :new_chat?, on_failure: :finish_him
          step :model
          step :save
          fail :log_errors
        end

        private

        def new_chat?(chat:, **)
          !Chat.exists?(id: chat[:id], chat_type: chat[:type])
        end

        def model(chat:, **)
          ctx[:model] = Chat.new(id: chat[:id], chat_type: chat[:type])
        end

        def save(**)
          ctx[:model].save
        end

        def log_errors(**)
          Rails.logger.debug(ctx[:model].errors)
        end
      end
    end
  end
end
