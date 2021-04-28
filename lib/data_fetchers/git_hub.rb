# frozen_string_literal: true

module DataFetchers
  class GitHub
    def initialize(repo: 'petrokoriakin/scorecard-sample')
      @url = "https://api.github.com/repos/#{repo}/events"
    end

    def call
      data = JSON.parse(obtain_raw_data)
      data.map { |data_item| data_item['type'] }
      { prs: {}, reviews: {}, comments: {} }
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
  end
end
