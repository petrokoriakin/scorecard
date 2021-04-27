# frozen_string_literal: true

module DataFetchers
  class GitHub
    def initialize(repo: 'petrokoriakin/scorecard-sample')
      @url = "https://api.github.com/repos/#{repo}/events"
    end

    def call
      # fetches some data
    end
  end
end
