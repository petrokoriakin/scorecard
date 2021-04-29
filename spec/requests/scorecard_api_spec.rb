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

  describe 'repos index' do
    before { get '/repos' }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'repos' => [{ 'id' => 13, 'name' => 'some_repo' }, { 'id' => 26, 'name' => 'other_repo' }] })
    end
  end

  describe 'repos member' do
    before { get '/repos/some_repo' }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'id' => 13, 'name' => 'some_repo' })
    end
  end

  describe 'repo scores' do
    before { VCR.use_cassette('sample_repo_events') { get '/repos/some_repo/scores' } }

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
    before { VCR.use_cassette('sample_repo_events') { get '/repos/some_repo/scores/petrokoriakin' } }

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
