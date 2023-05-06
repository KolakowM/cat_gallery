Rails.application.routes.draw do
  devise_for :users

  resources :items
  root "items#index" do
    collection do
      get :my_items
    end
  end
end
