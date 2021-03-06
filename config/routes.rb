Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'questions#index'
  resources :users, only: [:show, :index, :new, :create]
  resource :sessions, only:[:new, :create, :destroy]
  resources :questions do
    resources :comments, except: [:show] do
    end
  end

  resources :questions do
    resources :answers
  end
  resources :answers, except: [:show] do
    resources :comments, except: [:show, :index] do
    end
  end

  resources :tags, only: [:show, :index]
  resources :questions, only:[] do
    resources :votes, only:[:create]
  end
  resources :answers, only:[] do
    resources :votes, only:[:create]
  end
  post '/tags/search' => 'tags#search'
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  get '/register' => 'users#new'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
