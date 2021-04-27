# frozen_string_literal: true

class ScoresController < ApplicationController
  def index
    render json: { scores: [{ id: 13, name: 'some_score' }] }
  end
end
