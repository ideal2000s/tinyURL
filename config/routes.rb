Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'links#index'
  resources :links, only: [:index, :new, :create]
  get 'links/:path', to: 'links#redirect', as: 'link_redirect'
  get 'links/:path/info', to: 'links#show', as: 'link'
end
