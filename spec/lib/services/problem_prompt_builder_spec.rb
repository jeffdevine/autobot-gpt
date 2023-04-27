require 'spec_helper'
require_relative '../../../lib/services/problem_prompt_builder'

RSpec.describe(ProblemPromptBuilder) do
  describe('#call') do
    it 'returns a success monad' do
      response = described_class.call(requirement: 'requirement')

      expect(response.success?).to be(true)
    end

    it 'returns a prompt that includes the provided string' do
      response = described_class.call(requirement: 'write a game')

      expect(response.value!).to include('quantify this problem: write a game')
    end

    context('when the requirement is not provided') do
      it 'returns a failure monad' do
        response = described_class.call(requirement: false)

        expect(response.success?).to be(false)
      end

      it 'logs an error message' do
        mock_logger = double

        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        expect(mock_logger).to receive(:fatal).with('false violates constraints (type?(String, false) failed)')

        described_class.call(requirement: false)
      end
    end
  end
end
