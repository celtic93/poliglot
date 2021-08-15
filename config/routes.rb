Rails.application.routes.draw do
  resources :lessons, only: :show
  resources :pronoun_forms, except: :show
  resources :verbs, only: %w(index edit update)
  resources :verb_pronoun_forms, except: %w(show edit update)
  patch 'check_phrase', to: 'phrases#check_phrase'

  telegram_webhook TelegramWebhooksController
end
