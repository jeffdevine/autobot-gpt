require "spec_helper"
require_relative "../../../lib/models/problem"
require_relative "../../../lib/services/orchestrator"

RSpec.describe(Orchestrator) do
  let(:pager) { class_double(TTY::Pager, page: true) }
  let(:prompt) { instance_double(TTY::Prompt, ask: "Solve fizz buzz", say: true, yes?: true) }
  let(:success) { Dry::Monads::Result::Mixin::Success.new("- DELIVERABLE: 1") }

  describe("#call") do
    it "returns a success monad" do
      mock_teletype
      allow(OpenAIClient).to receive(:call).and_return(success)

      response = described_class.call

      expect(response.success?).to be(true)
    end

    it "tells the user when the problem is not solvable by OpenAI" do
      mock_problem_failure
      mock_teletype

      described_class.call

      expect(prompt).to have_received(:say).with("This problem can not be solved with OpenAI.", color: :red)
    end
  end

  def mock_problem_failure
    failed_problem = Problem.new(requirements: "Solve fizz buzz", deliverables: "Not solvable")
    allow(ProblemEvaluator).to receive(:call)
      .and_return(Dry::Monads::Result::Mixin::Success.new(failed_problem))
  end

  def mock_teletype
    allow(TTY::Pager).to receive(:new).and_return(pager)
    allow(TTY::Prompt).to receive(:new).and_return(prompt)
  end
end
