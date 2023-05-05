require "spec_helper"
require_relative "../../../lib/models/problem"
require_relative "../../../lib/services/problem_evaluator"

RSpec.describe(ProblemEvaluator) do
  let(:failure) { Dry::Monads::Result::Mixin::Failure.new(false) }
  let(:success) { Dry::Monads::Result::Mixin::Success.new("- DELIVERABLE: 1") }

  describe("#call") do
    it "returns a success monad" do
      allow(OpenAIClient).to receive(:call).and_return(success)

      response = described_class.call(requirements: "write a soduku game")

      expect(response.success?).to be(true)
    end

    it "contains a populated problem object" do
      allow(OpenAIClient).to receive(:call).and_return(success)

      response = described_class.call(requirements: "write a soduku game")

      expect(response.value!).to be_a(Problem)
    end

    context("when OpenAI::Client raises an error") do
      it "returns a failure monad" do
        allow(OpenAIClient).to receive(:call).and_return(failure)

        response = described_class.call(requirements: "write a soduku game")

        expect(response.success?).to be(false)
      end
    end

    context("when the requirement is not provided") do
      it "returns a failure monad" do
        response = described_class.call(requirements: false)

        expect(response.success?).to be(false)
      end

      it "logs an error message" do
        mock_logger = instance_double(TTY::Logger, fatal: true)

        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        described_class.call(requirements: false)

        expect(mock_logger).to have_received(:fatal).with("false violates constraints (type?(String, false) failed)")
      end
    end
  end
end
