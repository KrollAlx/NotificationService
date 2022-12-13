Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post '/clients', to: 'clients#create'
  put '/clients/:id', to: 'clients#update'
  delete '/clients/:id', to: 'clients#delete'
end
