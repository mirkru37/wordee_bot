RSpec.describe Telegram::V1::ChatController, telegram_bot: :rails do
  describe '#start!' do
    subject(:send_command) { -> { dispatch_command :start, words } }

    context 'without additional words' do
      let(:words) { [] }
      let(:responce) { 'Empty start' }

      it 'recieve propper answer' do
        expect(send_command).to respond_with_message response
      end
    end

    context 'with additional words' do
      let(:words) { %w[word1 word2 word3] }
      let(:responce) { words[0] }

      it 'recieve propper answer' do
        expect(send_command).to respond_with_message response
      end
    end
  end

  describe '#send_message' do
    subject(:send_message) { -> { dispatch_message message } }

    let(:message) { 'Hello' }
    let(:responce) { "#{message}, " }

    it 'replies' do
      expect(send_message).to respond_with_message response
    end

    context 'with saving context' do
      before do
        send_message.call
      end

      it 'changes behaviour' do
        expect(send_message).to respond_with_message message
      end
    end
  end

  describe 'worng_command' do
    subject(:send_command) { -> { dispatch_command command } }

    let(:command) { :wrong }
    let(:responce) { "missing command #{command}" }

    it 'replyes' do
      expect(send_command).to respond_with_message response
    end
  end
end
