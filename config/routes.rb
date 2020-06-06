Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/webhook/', to: 'webhook#index', as: 'getwebhook'
  post '/webhook/', to: 'webhook#hooks', as: 'webhook'
end
