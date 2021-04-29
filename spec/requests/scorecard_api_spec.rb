# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scorecard API', type: :request, vcr: true do
  describe 'root endpoint' do
    before { VCR.use_cassette('sample_repo_events') { get '/', params: { repo_name: 'some_repo' } } }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'scores' => [{ 'contributor_name' => 'petrokoriakin', 'score' => 57 }] })
    end
  end

  describe 'repo scores' do
    before { VCR.use_cassette('sample_repo_events') { get '/github/petrokoriakin/scorecard-sample/scores' } }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'scores' => [{ 'contributor_name' => 'petrokoriakin', 'score' => 57 }] })
    end
  end

  describe 'repo score for user' do
    before do
      VCR.use_cassette('sample_repo_events') { get '/github/petrokoriakin/scorecard-sample/scores/petrokoriakin' }
    end

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data.keys).to eq(%w[contributor_name score score_details])
    end

    it 'renders score details' do
      data = JSON.parse(response.body)
      expect(data['score_details']).to eq({ 'prs_quantity' => 4, 'prs_points' => 48, 'reviews_quantity' => 2,
                                            'reviews_points' => 6, 'comments_quantity' => 3, 'comments_points' => 3 })
    end
  end
end
