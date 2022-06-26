RSpec.describe Common::Model do
  subject(:result) { described_class.call(ctx:, parent:, key:, methods:, options:) }

  let(:model_key) { :model }
  let(:method_key) { :method }

  let(:ctx) { {} }
  let(:parent) { nil }
  let(:key) { model_key }
  let(:methods) { method_key }
  let(:options) { {} }

  describe '#call' do
    let(:parent_double) { instance_double(Parent) }
    let(:method_return) { 5 }

    context 'without options' do
      before do
        stub_const('Parent', Class.new)
        allow(parent_double).to receive(method_key).and_return(method_return)
      end

      context 'with parent from context' do
        let(:parent) { :parent }
        let(:ctx) { { parent: parent_double } }

        it 'succeeds' do
          expect(result).to be_truthy
        end

        it 'saves model into context' do
          result
          expect(ctx[model_key]).to eq method_return
        end

        it 'calls method on parent' do
          result
          expect(ctx[:parent]).to have_received(method_key)
        end
      end

      context 'with parent from const' do
        let(:parent) { parent_double }

        it 'succeeds' do
          expect(result).to be_truthy
        end

        it 'saves model into context' do
          result
          expect(ctx[model_key]).to eq method_return
        end

        it 'calls method on parent' do
          result
          expect(parent).to have_received(method_key)
        end
      end

      context 'with method chain' do
        let(:methods) { %i[one two tree] }
        let(:parent) { parent_double }
        let(:methods_with_return) { methods[0...-1].product([parent_double]).to_h }

        before do
          allow(parent_double).to receive_messages(methods_with_return)
          allow(parent_double).to receive(methods[-1]).and_return(method_return)
        end

        it 'succeeds' do
          expect(result).to be_truthy
        end

        it 'saves model into context' do
          result
          expect(ctx[model_key]).to eq method_return
        end

        it 'calls methods on parent' do
          result
          methods.each do |method_key|
            expect(parent).to have_received(method_key).with(no_args)
          end
        end
      end
    end

    context 'with options' do
      let(:parent) { parent_double }
      let(:options) { { key: :value } }

      before do
        stub_const('Parent', Class.new)
        allow(parent_double).to receive(method_key).and_return(method_return)
      end

      it 'succeeds' do
        expect(result).to be_truthy
      end

      it 'saves model into context' do
        result
        expect(ctx[model_key]).to eq method_return
      end

      it 'calls method on parent' do
        result
        expect(parent).to have_received(method_key).with(options)
      end

      context 'with method chain' do
        let(:methods) { %i[one two tree] }
        let(:parent) { parent_double }
        let(:methods_with_return) { methods[0...-1].product([parent_double]).to_h }

        before do
          allow(parent_double).to receive_messages(methods_with_return)
          allow(parent_double).to receive(methods[-1]).and_return(method_return)
        end

        it 'succeeds' do
          expect(result).to be_truthy
        end

        it 'saves model into context' do
          result
          expect(ctx[model_key]).to eq method_return
        end

        it 'calls methods on parent' do
          result
          methods[0...-1].each do |method_key|
            expect(parent).to have_received(method_key).with(no_args)
          end
        end

        it 'calls last method with options' do
          result
          expect(parent).to have_received(methods[-1]).with(options)
        end
      end
    end
  end
end
