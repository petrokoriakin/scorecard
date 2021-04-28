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
      expect(service_result.keys).to eq(%w[prs reviews comments])
    end
  end
end
