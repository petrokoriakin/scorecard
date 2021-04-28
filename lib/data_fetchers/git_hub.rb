# frozen_string_literal: true

module DataFetchers
  class GitHub
    def initialize(repo: 'petrokoriakin/scorecard-sample')
      @url = "https://api.github.com/repos/#{repo}/events"
    end

    def call
      data = JSON.parse(obtain_raw_data)
      { prs: collect_prs_details(data), reviews: collect_reviews_details(data),
        comments: collect_comments_details(data) }
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

    def collect_prs_details(_data)
      [{ author: 'petrokoriakin', created_at: Time.zone.parse('2021-04-27 20:13:54') }]
    end

    def collect_reviews_details(_data)
      [{ author: 'petrokoriakin', created_at: Time.zone.parse('2021-04-27 20:13:54') }]
    end

    def collect_comments_details(_data)
      [{ author: 'petrokoriakin', created_at: Time.zone.parse('2021-04-27 20:13:54') }]
    end
  end
end
