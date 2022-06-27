Rails.application.routes.draw do
  root "pages#index"

  post '/', to: 'pages#create'
end
