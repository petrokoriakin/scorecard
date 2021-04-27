# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThingsController do
  describe '#index' do
    render_views

    it 'responds with :success', :vcr do
      get :index

      expect(response.status).to eq(200)
    end
  end
end
