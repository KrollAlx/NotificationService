Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  post '/clients', to: 'clients#create'
  put '/clients/:id', to: 'clients#update'
  delete '/clients/:id', to: 'clients#delete'

  post '/notifications', to: 'notifications#create'
  get '/notifications/statistics', to: 'notifications#statistics'
  get '/notifications/:id/statistics', to: 'notifications#details'
  put '/notifications/:id', to: 'notifications#update'
  delete '/notifications/:id', to: 'notifications#delete'
end
