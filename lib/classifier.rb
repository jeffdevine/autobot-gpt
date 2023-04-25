class Classifier
  attr_accessor :current_response, :deliverable_array,
                :full_dialogue, :human_feedback_count, :no_deliverables, :problem_state, :problem_statement,
                :run_count, :status

  def initialize
    @deliverable_array = []
    @human_feedback_count = 0
    @status = :not_started
    @run_count = 0
    @no_deliverables = 0
  end
end
