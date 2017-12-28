# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users, shallow: true, except: %i[index destroy] do
    resources :posts, except: [:index] do
      collection { post :import }
      member { post :like }
    end
  end

  resources :posts, only: [:index]

  resources :categories

  root 'posts#index'
end
