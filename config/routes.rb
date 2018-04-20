Rails.application.routes.draw do
  get 'analysis_results/index'

  get 'analysis_results/edit'

  get 'analysis_results/show'

  get 'analysis_results/destroy'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
