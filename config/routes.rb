Rails.application.routes.draw do

# resources :food
root 'food#index'
get '/generate_random' => 'food#generate', :as => :generate
get '/updates' => 'food#updates', :as => :updates


end
