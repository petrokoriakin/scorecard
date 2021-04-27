# frozen_string_literal: true

require 'spec_helper'
require 'data_fetchers/git_hub'

RSpec.describe DataFetchers::GitHub do
  it 'does smth' do
    expect(described_class.new).not_to be_nil
  end
end
