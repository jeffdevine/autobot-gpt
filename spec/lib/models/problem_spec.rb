require "spec_helper"
require_relative "../../../lib/models/problem"

RSpec.describe("Problem") do
  it 'has a default status of "not started"' do
    subject = Problem.new(requirements: "Tell a joke", deliverables: "- DELIVERABLE: 1")

    expect(subject.status).to be(:not_started)
  end

  describe("#deliverables?") do
    it 'returns true if the deliverables start with "- DELIVERABLE"' do
      subject = Problem.new(requirements: "Tell a joke", deliverables: "- DELIVERABLE: 1")

      expect(subject.deliverables?).to be(true)
    end

    it 'returns false if the deliverables do not start with "- DELIVERABLE"' do
      subject = Problem.new(requirements: "Tell a joke", deliverables: "False")

      expect(subject.deliverables?).to be(false)
    end
  end
end
