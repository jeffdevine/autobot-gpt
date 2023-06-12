require "tty-pager"
require "tty-prompt"
require_relative "problem_evaluator"
require_relative "service"

class Orchestrator < Service
  def call
    decompose_problem if evaluate_problem
    Success.new(prompt.say("Job complete"))
  end

  private

  def decompose_problem
    true
  end

  def evaluate_problem
    if problem.deliverables?
      pager.page("These are the deliverables:\n #{problem.deliverables}")
      prompt.yes?("Send the deliverables to OpenAI to write this code?", color: :green)
    else
      prompt.say("This problem can not be solved with OpenAI.", color: :red)
      false
    end
  end

  def pager
    @pager ||= TTY::Pager.new
  end

  def problem
    @problem ||= ProblemEvaluator.call(requirements:).value!
  end

  def prompt
    @prompt ||= TTY::Prompt.new
  end

  def requirements
    @requirements ||= prompt.ask("What problem would you like to solve with software?")
  end
end
