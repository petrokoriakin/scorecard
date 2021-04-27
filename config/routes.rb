# frozen_string_literal: true

Rails.application.routes.draw do
  resources :repos, param: :repo_name, only: %i[index show] do
    member do
      resources :scores, param: :user_name, only: %i[index show]
    end
  end

  get '/', to: 'scores#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
