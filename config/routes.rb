Rails.application.routes.draw do
  resource :github_webhooks, only: :create, defaults: { formats: :json }
  resources :tools, except: [:destroy, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
