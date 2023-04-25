require 'spec_helper'
require_relative '../../lib/classifier'

RSpec.describe('Classifier') do
  it 'has a default status of "not started"' do
    subject = Classifier.new

    expect(subject.status).to be(:not_started)
  end
end
