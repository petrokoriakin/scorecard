# frozen_string_literal: true

class ScoresController < ApplicationController
  def index
    render json: { 'scores' => [{ 'id' => 13, 'name' => 'user1', 'score' => 99, 'repo_name' => params[:repo_name] },
                                { 'id' => 14, 'name' => 'user2', 'score' => 77, 'repo_name' => params[:repo_name] }] }
  end

  def show
    details = { 'prs_quantity' => 4, 'prs_points' => 48, 'reviews_quantity' => 2, 'reviews_points' => 6,
                'comments_quantity' => 5, 'comments_score' => 5 }
    render json: { 'id' => 14, 'name' => params[:user_name], 'score' => 77, 'repo_name' => params[:repo_name],
                   'score_details' => details }
  end
end
