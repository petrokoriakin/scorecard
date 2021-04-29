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
    org = params.fetch(:org, 'petrokoriakin')
    repo = params.fetch(:repo, 'scorecard-sample')
    author = params.fetch(:author, nil)
    events = DataFetchers::GitHub.new(org: org, repo: repo).call
    ScoresComposer.new(data: filtered(events)).call(author: author)
  end

  # Services know nothing about assignment details, so dates and sample repo is handeled here
  def filtered(unfiltered)
    target_period = obtain_period
    {
      events: unfiltered[:events].select { |event| target_period.cover?(event[:created_at]) }
    }
  end

  def obtain_period
    return default_day if params[:repo].blank? || params[:repo] == 'scorecard-sample'

    (Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
  end

  def default_day
    (Time.zone.parse('2021-04-27')..Time.zone.parse('2021-04-27').end_of_day)
  end
end
