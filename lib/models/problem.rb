require 'yaml'

class Problem
  attr_accessor :status
  attr_reader :deliverables, :requirements

  def initialize(requirements, deliverables)
    @deliverables = deliverables
    @requirements = requirements
    @status = :not_started
  end

  def deliverables?
    @deliverables.start_with?('- DELIVERABLE')
  end
end
