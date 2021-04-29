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

  def initialize(data: {})
    @data = data
  end

  def call(_author: nil); end
end
