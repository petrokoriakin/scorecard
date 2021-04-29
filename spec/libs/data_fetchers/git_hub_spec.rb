# frozen_string_literal: true

require 'rails_helper'
require 'data_fetchers/git_hub'

RSpec.describe DataFetchers::GitHub, :vcr do
  it 'does smth' do
    expect(described_class.new).not_to be_nil
  end

  describe '#call' do
    subject(:service_result) { VCR.use_cassette('sample_repo_events') { described_class.new.call } }

    let(:result_pr_event) { service_result[:events].find { |event| event[:type] ==  ScoresComposer::PR } }
    let(:result_review_event) { service_result[:events].find { |event| event[:type] == ScoresComposer::REVIEW } }
    let(:result_comment_event) { service_result[:events].find { |event| event[:type] == ScoresComposer::COMMENT } }

    it 'returns a hash' do
      expect(service_result).to be_a(Hash)
    end

    it 'returns appropriate keys' do
      expect(service_result.keys).to eq([:events])
    end

    it 'reveals events' do
      expect(service_result[:events]).to be_a(Array)
    end

    it 'reveals pr details' do
      expect(result_pr_event).to eq({ author: 'petrokoriakin', type: ScoresComposer::PR,
                                      created_at: Time.zone.parse('2021-04-27 16:45:32') })
    end

    it 'reveals review details' do
      expect(result_review_event).to eq({ author: 'petrokoriakin', type: ScoresComposer::REVIEW,
                                          created_at: Time.zone.parse('2021-04-27 16:38:21') })
    end

    it 'reveals comment details' do
      expect(result_comment_event).to eq({ author: 'petrokoriakin', type: ScoresComposer::COMMENT,
                                           created_at: Time.zone.parse('2021-04-27 16:45:15') })
    end
  end
end
