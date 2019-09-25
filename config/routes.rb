Rails.application.routes.draw do
  
  get 'home/index'
  devise_for :users



  resources :appointments do
    get "update_status/:status", to: "appointments#update_status"
    get "send_prescription", to: "appointments#send_prescription"
    post "save_prescription", to: "appointments#save_prescription", on: :collection
  end

  root :to => "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
