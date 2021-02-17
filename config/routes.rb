Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index]
  get 'users/archive/:id' => 'users#archive', as: :archive
  get 'users/unarchive/:id' => 'users#unarchive', as: :unarchive
end
