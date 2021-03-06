Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
   namespace :v1 do
     resources :hotels do
       resources :hotel_tables
       resources :hotel_shifts
     end
     resources :guests
     resources :reservations
   end
  end
end
