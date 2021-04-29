# frozen_string_literal: true

module DataFetchers
  class GitHub
    GITHUB_EVENTS = [
      PR_EVENT = 'PullRequestEvent',
      COMMENT_EVENT = 'IssueCommentEvent',
      REVIEW_EVENT =  'PullRequestReviewEvent'
    ].freeze

    GITHUB_MAPPING = {
      PR_EVENT => 'pr',
      COMMENT_EVENT => 'comment',
      REVIEW_EVENT => 'review'
    }.freeze

    def initialize(repo: 'petrokoriakin/scorecard-sample')
      @url = "https://api.github.com/repos/#{repo}/events"
    end

    def call
      data = JSON.parse(obtain_raw_data)
      { events: process_events(data) }
    end

    private

    def obtain_raw_data
      uri = URI.parse('https://api.github.com/repos/petrokoriakin/scorecard-sample/events')
      request = Net::HTTP::Get.new(uri)
      request['Accept'] = 'application/vnd.github.v3+json'
      req_options = {
        use_ssl: uri.scheme == 'https'
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      response.body
    end

    def process_events(data)
      data.each_with_object([]) do |item, result|
        result << collect_details(item) if GITHUB_EVENTS.include?(item['type'])
      end
    end

    def collect_details(event)
      { author: event['actor']['display_login'],
        type: GITHUB_MAPPING[event['type']],
        created_at: Time.zone.parse(event['created_at']) }
    end
  end
end
