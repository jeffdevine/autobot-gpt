require 'spec_helper'
require_relative '../../../lib/models/problem'
require_relative '../../../lib/services/problem_evaluator'

RSpec.describe(ProblemEvaluator) do
  describe('#call') do
    it 'returns a success monad' do
      success = Dry::Monads::Result::Mixin::Success.new('- DELIVERABLE: 1')

      allow_any_instance_of(OpenAIClient).to receive(:call).and_return(success)

      response = described_class.call(requirements: 'write a soduku game')

      expect(response.success?).to be(true)
    end

    it 'contains a populated problem object' do
      success = Dry::Monads::Result::Mixin::Success.new('- DELIVERABLE: 1')

      allow_any_instance_of(OpenAIClient).to receive(:call).and_return(success)

      response = described_class.call(requirements: 'write a soduku game')

      expect(response.value!).to be_a(Problem)
    end

    context('when OpenAI::Client raises an error') do
      it 'returns a failure monad' do
        failure = Dry::Monads::Result::Mixin::Failure.new('- DELIVERABLE: 1')

        allow_any_instance_of(OpenAIClient).to receive(:call).and_return(failure)

        response = described_class.call(requirements: 'write a soduku game')

        expect(response.success?).to be(false)
      end
    end

    context('when the requirement is not provided') do
      it 'returns a failure monad' do
        response = described_class.call(requirements: false)

        expect(response.success?).to be(false)
      end

      it 'logs an error message' do
        mock_logger = double

        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        expect(mock_logger).to receive(:fatal).with('false violates constraints (type?(String, false) failed)')

        described_class.call(requirements: false)
      end
    end
  end
end
