require_relative "service"

class CodePromptBuilder < Service
  option :deliverable, type: Dry::Types["strict.string"]
  option :previous_code, optional: true, type: Dry::Types["strict.string"]
  option :requirements, type: Dry::Types["strict.string"]

  Schema = Dry::Schema.Params do
    required(:deliverable).filled
    required(:requirements).filled
  end

  def call
    Success.new(build_prompt)
  end

  private

  def build_prompt
    prompt = extended_prompt
    prompt = "#{prompt}\nPrevious code: #{@previous_code}" unless @previous_code == Dry::Initializer::UNDEFINED
    prompt
  end

  def extended_prompt
    "#{generate_code_prompt}\n Deliverable: #{@deliverable}\n Requirements: #{@requirements}"
  end

  def generate_code_prompt
    File.read("lib/prompts/generate_code.txt")
  end
end
