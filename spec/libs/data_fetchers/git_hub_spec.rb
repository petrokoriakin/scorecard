# frozen_string_literal: true

require 'spec_helper'
require 'data_fetchers/git_hub'

RSpec.describe DataFetchers::GitHub, :vcr do
  it 'does smth' do
    expect(described_class.new).not_to be_nil
  end

  describe '#call' do
    subject(:service) { described_class.new }

    it 'returns a string' do
      expect(service.call).to be_a(Hash)
    end
  end
end
