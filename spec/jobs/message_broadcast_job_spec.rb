require 'rails_helper'

RSpec.describe MessageBroadcastJob, type: :job do
  include ActiveJob::TestHelper

  after do
    clear_enqueued_jobs
  end

  it 'should queue the job when a message is created' do
    message = create :message
    expect(enqueued_jobs.size).to eq 1
  end

  it 'should brodcast the message through ActionCable' do
    expect(ActionCable.server).to receive(:broadcast)
    perform_enqueued_jobs { create :message }
  end
end
