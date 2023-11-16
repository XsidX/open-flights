Rails.application.routes.draw do
  root 'pages#index' # this syntax means that the root path will be handled by the index action of the pages controller

  namespace :api do
    namespace :v1 do
      resources :airlines, param: :slug # instead of using id as primary param
      resources :reviews, only: [:create, :destroy] #scope it down
    end
  end

  get '*path', to: 'pages#index', via: :all # allow handling routing to react components without
                                            #interfering with rails routes to our api 
end
