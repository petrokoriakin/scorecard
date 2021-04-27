# frozen_string_literal: true

class Channel < ActiveResource::Base
  self.site = 'https://api.audioaddict.com/v1/di/channels.json'
end
