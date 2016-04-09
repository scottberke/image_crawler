Rails.application.routes.draw do

  # post 'jobs' => 'jobs#create'
  resources :jobs, only: [:create] do
    member do
      get 'status'
      get 'results'
    end
  end

end
