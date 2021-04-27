# frozen_string_literal: true

require 'rails_helper'

RSpec.xdescribe 'Scorecard API', type: :request, vcr: true do
  describe 'root endpoint' do
    before { get '/' }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'scores' => [{ 'id' => 13, 'name' => 'some_score' }] })
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
    before { get '/repos/some_repo/scores' }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data).to eq({ 'scores' => [{ 'id' => 13, 'name' => 'user1', 'score' => 99, 'repo_name' => 'some_repo' },
                                        { 'id' => 14, 'name' => 'user2', 'score' => 77, 'repo_name' => 'some_repo' }] })
    end
  end

  describe 'repo score for user' do
    before { get '/repos/some_repo/scores/user1' }

    it 'renders json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders data' do
      data = JSON.parse(response.body)
      expect(data.keys).to eq(%w[id name score repo_name score_details])
    end

    it 'renders score details' do
      data = JSON.parse(response.body)
      expect(data['score_details']).to eq({ 'pr_quantity' => 4, 'pr_points' => 48, 'reviews_quantity' => 2,
                                            'reviews_points' => 6, 'comments_quantity' => 5, 'comments_score' => 5 })
    end
  end
end
