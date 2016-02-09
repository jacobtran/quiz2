Rails.application.routes.draw do
  resources :support_requests

  # setting the home page
  root "support_requests#index"
end
