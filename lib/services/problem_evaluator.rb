require_relative "open_ai_client"
require_relative "../models/problem"
require_relative "problem_prompt_builder"
require_relative "service"

class ProblemEvaluator < Service
  attr_reader :requirements

  option :requirements, type: Dry::Types["strict.string"]

  def call
    Success.new(evaulate_requirements)
  rescue => e
    log_with_failure(e.message)
  end

  private

  def deliverables
    @deliverables ||= OpenAIClient.call(message:).value!
  end

  def evaulate_requirements
    Problem.new(requirements:, deliverables:)
  end

  def message
    @message ||= ProblemPromptBuilder.call(requirements:).value!
  end
end
