# frozen_string_literal: true

require 'spec_helper'
require 'data_fetchers/git_hub'

RSpec.describe DataFetchers::GitHub, :vcr do
  it 'does smth' do
    expect(described_class.new).not_to be_nil
  end

  describe '#call' do
    subject(:service_result) { VCR.use_cassette('sample_repo_events') { described_class.new.call } }

    it 'returns a hash' do
      expect(service_result).to be_a(Hash)
    end

    it 'returns appropriate keys' do
      expect(service_result.keys).to eq(%i[prs reviews comments])
    end

    it 'reveals prs' do
      expect(service_result[:prs]).to be_a(Array)
    end

    it 'reveals reviews' do
      expect(service_result[:reviews]).to be_a(Array)
    end

    it 'reveals comments' do
      expect(service_result[:comments]).to be_a(Array)
    end

    it 'reveals pr details' do
      expect(service_result[:prs].first).to eq({ author: 'petrokoriakin',
                                                 created_at: Time.zone.parse('2021-04-27 20:13:54') })
    end

    it 'reveals review details' do
      expect(service_result[:reviews].first).to eq({ author: 'petrokoriakin',
                                                     created_at: Time.zone.parse('2021-04-27 20:13:54') })
    end

    it 'reveals comment details' do
      expect(service_result[:comments].first).to eq({ author: 'petrokoriakin',
                                                      created_at: Time.zone.parse('2021-04-27 20:13:54') })
    end
  end
end
