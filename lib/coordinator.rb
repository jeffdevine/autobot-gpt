class Coordinator
  attr_accessor :classifier, :current_deliverable,
                :deliverables_array, :deliverable_statement,
                :no_deliverables, :openai_object, :status

  def initialize
    # @classifier = Classifier.new
    @current_deliv = 0
    @deliverables_array = []
    @no_deliverables = 0
    @status = :not_started
  end
end
