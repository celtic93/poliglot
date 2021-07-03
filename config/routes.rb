Rails.application.routes.draw do
  get 'lesson1', to: 'lessons#lesson1'
  patch 'check_phrase', to: 'phrases#check_phrase'
end
