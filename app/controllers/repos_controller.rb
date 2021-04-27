# frozen_string_literal: true

class ReposController < ApplicationController
  def index
    render json: { 'repos' => [{ 'id' => 13, 'name' => 'some_repo' }, { 'id' => 26, 'name' => 'other_repo' }] }
  end

  def show
    render json: { 'id' => 13, 'name' => params[:repo_name] }
  end
end
