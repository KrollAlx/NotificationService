Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'clients/create'
  get 'clients/update'
  get 'clients/delete'

  # Defines the root path route ("/")
  # root "articles#index"
end
