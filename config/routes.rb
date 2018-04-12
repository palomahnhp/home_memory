Rails.application.routes.draw do
  devise_for :users

  root to: "patients#index"

  resources :medical_centers
  resources :analyses do
    collection { post :import }
  end
  resources :prescriptions
  resources :appointments
  resources :medications
  resources :histories
  resources :professionals
  resources :patients
  resources :specialities
  resources :medical_histories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
