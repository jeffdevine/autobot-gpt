require "spec_helper"
require_relative "../../../lib/services/open_ai_client"

RSpec.describe(OpenAIClient) do
  describe("#call") do
    it "returns a success monad" do
      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({"choices" => []})

      response = described_class.call(message: "tell a joke")

      expect(response.success?).to be(true)
    end

    it "returns a response based on provided string" do
      content = {"content" => "Why did the tomato turn red? Because it saw the salad dressing!"}
      message = {"message" => content}

      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({"choices" => [message]})

      response = described_class.call(message: "tell a joke")

      expect(response.value!).to include("Why did the tomato turn red?")
    end

    it "logs the response from OpenAI when DEBUG is set" do
      ENV["DEBUG"] = "true"
      mock_logger = double

      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({"choices" => []})
      allow(TTY::Logger).to receive(:new).and_return(mock_logger)

      expect(mock_logger).to receive(:debug).with({"choices" => []})

      described_class.call(message: "tell a joke")

      ENV["DEBUG"] = nil
    end

    context("when OpenAI::Client raises an error") do
      it "returns a failure monad" do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_raise(StandardError)

        response = described_class.call(message: "tell a joke")

        expect(response.success?).to be(false)
      end

      it "logs an error message" do
        mock_logger = double

        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_raise(StandardError)
        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        expect(mock_logger).to receive(:error).with("[OpenAIClient] - StandardError")

        described_class.call(message: "tell a joke")
      end
    end

    context("when the requirement is not provided") do
      it "returns a failure monad" do
        response = described_class.call(message: false)

        expect(response.success?).to be(false)
      end

      it "logs an error message" do
        mock_logger = double

        allow(TTY::Logger).to receive(:new).and_return(mock_logger)

        expect(mock_logger).to receive(:fatal).with("false violates constraints (type?(String, false) failed)")

        described_class.call(message: false)
      end
    end
  end
end
