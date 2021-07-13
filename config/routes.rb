Rails.application.routes.draw do
  resources :lessons, only: :show
  resources :pronoun_forms, except: :show
  patch 'check_phrase', to: 'phrases#check_phrase'
end
