# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScoresController, :vcr do
  describe '#index' do
    render_views

    it 'responds with :success' do
      VCR.use_cassette('sample_repo_events') { get :index }

      expect(response.status).to eq(200)
    end
  end
end
