RSpec.describe Common::AddErrors do
  subject(:result) { described_class.call(ctx:, obj:, error_store:, errors:) }

  let(:ctx) { {} }
  let(:error_store) { Decouplio::DefaultErrorHandler.new }
  let(:errors) { [] }
  let(:obj) { [] }

  describe '#call' do
    let(:attribute) { :base }
    let(:error_msg) { 'Error!' }

    context 'with hash of errors' do
      let(:errors) { { attribute => error_msg } }

      it 'succeeds' do
        expect(result).to be_truthy
      end

      it 'write errors' do
        result
        expect(error_store.errors[attribute]).to contain_exactly error_msg
      end
    end

    context 'with obj' do
      let(:error_double) { instance_double(Error) }
      let(:object_double) { instance_double(Dummy) }
      let(:obj) { :object }
      let(:ctx) { { object: object_double } }

      before do
        stub_const('Error', Class.new)
        stub_const('Dummy', Class.new)
        allow(error_double).to receive(:attribute).and_return(attribute)
        allow(error_double).to receive(:message).and_return(error_msg)
        allow(object_double).to receive(:errors).and_return([error_double])
      end

      it 'succeeds' do
        expect(result).to be_truthy
      end

      it 'write errors' do
        described_class.call(ctx:, obj:, error_store:, errors:)
        expect(error_store.errors[attribute]).to contain_exactly error_msg
      end
    end

    context 'without errors and obj' do
      it 'fails' do
        expect(result).to be_falsey
      end
    end
  end
end
