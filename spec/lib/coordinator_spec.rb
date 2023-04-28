require "spec_helper"
require_relative "../../lib/coordinator"

RSpec.describe("Coordinator") do
  it 'has a default status of "not started"' do
    subject = Coordinator.new

    expect(subject.status).to be(:not_started)
  end
end
