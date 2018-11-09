Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :exchanges
  resources :payins
  resources :payouts

  get '/revenue' => 'revenues#show'
  get '/duplicates' => 'exchanges#duplicates'

end
