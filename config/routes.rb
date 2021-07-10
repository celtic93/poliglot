Rails.application.routes.draw do
  resources :lessons, only: :show
  patch 'check_phrase', to: 'phrases#check_phrase'
end
