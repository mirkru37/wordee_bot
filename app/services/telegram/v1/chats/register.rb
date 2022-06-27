module Telegram
  module V1
    module Chats
      class Register < BaseService
        logic do
          step :new_chat?
          aide ::Common::AddErrors, errors: { model: 'Chat already exists' }
          doby ::Common::Model, parent: Chat, methods: :create, options: { id: %i[chat id], chat_type: %i[chat type] }
        end

        private

        def new_chat?(chat:, **)
          !Chat.exists?(id: chat[:id], chat_type: chat[:type])
        end
      end
    end
  end
end
