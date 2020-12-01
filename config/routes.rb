Rails.application.routes.draw do

  get '/index', to: 'index#index'

  post '/upload', to: 'cnab#upload', as: 'cnab_upload'
  get '/transactions', to: 'transaction#index'

  root to: 'index#index'

end
