# frozen_string_literal: true

class ScoresComposer
  EVENT_TYPES = [
    PR = 'pr',
    REVIEW = 'review',
    COMMENT = 'comment'
  ].freeze

  EVENT_SCORES = {
    PR => 12,
    REVIEW => 3,
    COMMENT => 1
  }.freeze

  EVENT_KEYS = {
    PR => { quantity: :prs_quantity, score: :prs_points },
    REVIEW => { quantity: :reviews_quantity, score: :reviews_points },
    COMMENT => { quantity: :comments_quantity, score: :comments_points }
  }.freeze

  def initialize(data: {})
    @data = data
  end

  def call(author: nil)
    scored_data = compose_score(author)

    scored_data.map do |(contributor, details)|
      { contributor_name: contributor, score: details.values_at(score_keys).sum, score_details: details }
    end
  end

  private

  def compose_score(author)
    filtered_data_for(author).each_with_object({}) do |event, result|
      event_author, event_type = event.values_at(:author, :type)
      result[event_author] ||= Hash.new(0)
      result[event_author][quantity_key_for(event_type)] += 1
      result[event_author][score_key_for(event_type)] += EVENT_SCORES[event_type]
    end
  end

  def filtered_data_for(author = nil)
    return @data[:events] if author.nil?

    @data[:events].select { |event| event[:author] == author }
  end

  def quantity_key_for(event_type)
    EVENT_KEYS[event_type][:quantity]
  end

  def score_key_for(event_type)
    EVENT_KEYS[event_type][:score]
  end

  def score_keys
    EVENT_KEYS.values.pluck(:score)
  end
end
