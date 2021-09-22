Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root 'static_pages#home', as: 'home'
    get 'static_pages/help', as: 'help'

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    resources :users
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :account_activations, only: :edit

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete"/logout", to: "sessions#destroy"
  end
end
