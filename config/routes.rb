# frozen_string_literal: true

Rails.application.routes.draw do
  get 'github/:org/:repo/scores', to: 'scores#index'
  get 'github/:org/:repo/scores/:author', to: 'scores#show'

  get '/', to: 'scores#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
