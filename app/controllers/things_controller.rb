# frozen_string_literal: true

class ThingsController < ApplicationController
  def index
    @things = [{ id: 13, name: 'some_score' }]
  end
end
