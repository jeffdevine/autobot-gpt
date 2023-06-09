require_relative "service"

class ProblemPromptBuilder < Service
  PROMPT = "This is an automation pipeline, please respond exactly as described below, do not deviate.".freeze

  option :requirements, type: Dry::Types["strict.string"]

  def call
    Success.new(build_prompt)
  end

  private

  def build_prompt
    "#{PROMPT} First, quantify this problem: #{@requirements}\n#{extended_prompt}"
  end

  def extended_prompt
    File.read("lib/prompts/software_requirement.txt")
  end
end
