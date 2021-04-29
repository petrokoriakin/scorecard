# frozen_string_literal: true

require 'rails_helper'
require 'scores_composer'

RSpec.describe ScoresComposer do
  let(:sample_author) { 'author' }
  let(:another_author) { 'another_author' }
  let(:sample_data) do
    {
      events: [
        { author: sample_author, type: ScoresComposer::COMMENT, created_at: Time.zone.parse('2021-04-27 16:45:15') },
        { author: sample_author, type: ScoresComposer::REVIEW, created_at: Time.zone.parse('2021-04-27 16:38:21') },
        { author: sample_author, type: ScoresComposer::PR, created_at: Time.zone.parse('2021-04-27 16:45:32') },
        { author: another_author, type: ScoresComposer::COMMENT, created_at: Time.zone.parse('2021-04-27 16:45:15') },
        { author: another_author, type: ScoresComposer::REVIEW, created_at: Time.zone.parse('2021-04-27 16:38:21') },
        { author: another_author, type: ScoresComposer::PR, created_at: Time.zone.parse('2021-04-27 16:45:32') }
      ]
    }
  end

  it 'does smth' do
    expect(described_class.new).not_to be_nil
  end

  context 'when author is nil' do
    subject(:result_without_author) { described_class.new(data: sample_data).call }

    it 'returns scores for sample author' do
      expect(result_without_author.first.keys).to eq(%w[contributor_name score score_details])
    end

    it 'returns score details sample author' do
      expect(result_without_author.first[:score_details]).to eq(
        { prs_quantity: 4, prs_points: 48, reviews_quantity: 2, reviews_points: 6, comments_quantity: 5,
          comments_score: 5 }
      )
    end

    it 'returns scores for another author' do
      expect(result_without_author.last.keys).to eq(%w[contributor_name score score_details])
    end

    it 'returns score details another author' do
      expect(result_without_author.last[:score_details]).to eq(
        { prs_quantity: 4, prs_points: 48, reviews_quantity: 2, reviews_points: 6, comments_quantity: 5,
          comments_score: 5 }
      )
    end
  end

  context 'when author is given' do
    subject(:result_without_author) { described_class.new(data: sample_data).call(author: sample_author) }

    it 'returns scores for sample author' do
      expect(result_without_author.first.keys).to eq(%w[contributor_name score score_details])
    end

    it 'returns score details sample author' do
      expect(result_without_author.first[:score_details]).to eq(
        { prs_quantity: 4, prs_points: 48, reviews_quantity: 2, reviews_points: 6, comments_quantity: 5,
          comments_score: 5 }
      )
    end
  end
end
