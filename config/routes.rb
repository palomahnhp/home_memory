Rails.application.routes.draw do

  devise_for :users

  root to: "patients#index"

  resources :medical_centers
  resources :medical_tests do
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
  resources :analysis_results
  resources :analytical_groups  do
    collection { post :import }
  end
  resources :analytical_subgroups
  resources :analytical_items

  resources :documents, only: [:destroy]
  resources :images, only: [:destroy]
  resources :direct_uploads, only: [:create]
  delete "direct_uploads/destroy", to: "direct_uploads#destroy", as: :direct_upload_destroy

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
