require "spec_helper"
require_relative "../../../lib/services/code_prompt_builder"

RSpec.describe(CodePromptBuilder) do
  describe("#call") do
    it "returns a success monad" do
      response = described_class.call(
        deliverable: "deliverable", requirements: "requirement"
      )

      expect(response.success?).to be(true)
    end

    it "returns a prompt that includes the provided deliverable" do
      response = described_class.call(
        deliverable: "deliverable", requirements: "requirement"
      )

      expect(response.value!).to include("You are given a YAML file that")
      expect(response.value!).to include("Deliverable: deliverable")
    end

    it "returns a prompt that includes previous code if it is provided" do
      response = described_class.call(
        deliverable: "deliverable", requirements: "requirement", previous_code: "code"
      )

      expect(response.value!).to include("You are given a YAML file that")
      expect(response.value!).to include("Previous code: code")
    end

    context("when the requirement is not provided") do
      it "returns a failure monad" do
        response = described_class.call(requirements: false)

        expect(response.success?).to be(false)
      end

      it "logs an error message" do
        mock_logger = double

        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        expect(mock_logger).to receive(:fatal).with("false violates constraints (type?(String, false) failed)")

        described_class.call(deliverable: false, requirements: "requirement")
      end
    end
  end
end
