module Telegram
  module V1
    module Chats
      class Register < BaseService
        logic do
          step :new_chat?
          aide ::Common::AddErrors, errors: { model: 'Chat already exists' }, on_success: :finish_him
          doby ::Common::Model, parent: Chat, methods: :create, options: { id: :id, chat_type: :chat_type }
        end

        private

        def new_chat?(id:, chat_type:, **)
          !Chat.exists?(id:, chat_type:)
        end
      end
    end
  end
end
