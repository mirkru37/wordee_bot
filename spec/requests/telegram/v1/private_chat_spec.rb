RSpec.describe Telegram::V1::PrivateChatController, telegram_bot: :rails do
  let(:chat) { { id: chat_id, type: :private } }

  describe '#start' do
    subject(:command) { -> { dispatch_command :start } }

    it { expect { command.call }.to respond_with_message }

    it { expect { command.call }.to change(Chat, :count).by(1) }
  end
end
