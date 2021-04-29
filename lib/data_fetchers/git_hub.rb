# frozen_string_literal: true

require 'scores_composer'

module DataFetchers
  class GitHub
    GITHUB_EVENTS = [
      PR_EVENT = 'PullRequestEvent',
      COMMENT_EVENT = 'IssueCommentEvent',
      REVIEW_EVENT =  'PullRequestReviewEvent'
    ].freeze

    GITHUB_MAPPING = {
      PR_EVENT => ScoresComposer::PR,
      COMMENT_EVENT => ScoresComposer::COMMENT,
      REVIEW_EVENT => ScoresComposer::REVIEW
    }.freeze

    def initialize(org: 'petrokoriakin', repo: 'scorecard-sample')
      @uri = "https://api.github.com/repos/#{org}/#{repo}/events"
    end

    def call
      data = JSON.parse(obtain_raw_data)
      { events: process_events(data) }
    end

    private

    def obtain_raw_data
      uri = URI.parse(@uri)
      response = Net::HTTP.start(uri.hostname, uri.port, { use_ssl: true }) do |http|
        request = Net::HTTP::Get.new(uri)
        request['Accept'] = 'application/vnd.github.v3+json'
        http.request(request)
      end
      response.body
    end

    def process_events(data)
      data.each_with_object([]) do |item, result|
        result << collect_details(item) if reasonable?(item)
      end
    end

    def reasonable?(event)
      [COMMENT_EVENT, REVIEW_EVENT].include?(event['type']) ||
        (PR_EVENT == event['type'] && event['payload']['action'] == 'closed')
    end

    def collect_details(event)
      { author: event['actor']['display_login'],
        type: GITHUB_MAPPING[event['type']],
        created_at: Time.zone.parse(event['created_at']) }
    end
  end
end
