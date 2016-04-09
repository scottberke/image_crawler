Rails.application.routes.draw do

  resources :jobs, only: [:create] do
    member do
      get 'status'
      get 'results'
    end
  end

end
