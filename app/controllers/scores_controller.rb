# frozen_string_literal: true

require 'data_fetchers/git_hub'
require 'scores_composer'

class ScoresController < ApplicationController
  def index
    render json: { 'scores' => scores_data.map { |item| item.slice(:contributor_name, :score) } }
  end

  def show
    render json: scores_data.first
  end

  private

  def scores_data
    events = DataFetchers::GitHub.new.call
    ScoresComposer.new(data: events).call(author: params[:user_name])
  end
end
