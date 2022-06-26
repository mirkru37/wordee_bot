RSpec.describe Telegram::V1::Chats::Register do
  subject(:result) { described_class.call(id:, chat_type:) }

  let(:id) { 1 }
  let(:chat_type) { 'private' }

  context 'with new chat' do
    it 'succeeds' do
      expect(result).to be_success
    end

    it 'creates a new record' do
      expect { result }.to change(Chat, :count).from(0).to(1)
    end

    it 'passed id to the new record' do
      result
      expect(Chat.last.id).to eq(id)
    end

    it 'passed chat_type to the new record' do
      result
      expect(Chat.last.chat_type).to eq(chat_type)
    end
  end

  context 'with existing chat' do
    before do
      described_class.call(id:, chat_type:)
    end

    it 'fails' do
      expect(result).to be_failure
    end

    it 'does not create a new record' do
      expect { result }.not_to change(Chat, :count)
    end

    it 'have error' do
      expect(result.errors).not_to be_empty
    end
  end
end
