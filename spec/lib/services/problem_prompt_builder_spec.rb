require "spec_helper"
require_relative "../../../lib/services/problem_prompt_builder"

RSpec.describe(ProblemPromptBuilder) do
  describe("#call") do
    it "returns a success monad" do
      response = described_class.call(requirements: "requirement")

      expect(response.success?).to be(true)
    end

    it "returns a prompt that includes the provided string" do
      response = described_class.call(requirements: "write a game")

      expect(response.value!).to include("quantify this problem: write a game")
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

        expect(mock_logger).to have_received(:fatal)
      end
    end
  end
end
