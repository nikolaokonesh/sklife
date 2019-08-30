Rails.application.routes.draw do

  mount Notifications::Engine => "/notifications"
  devise_for :users

  concern :article do
    resources :categories, path: '/', except: :index do
      resources :comments, module: :categories
      resources :posts, module: :categories
    end
    resources :posts, except: [:index, :new, :create, :show, :destroy] do
      resources :comments, module: :posts
    end
  end

  constraints(Subdomain) do
    scope module: :article do
      scope module: :blog do
        concerns :article
      end
    end
    root to: "article/blog/categories#index", as: :subdomain_root
  end

  scope module: :article do
    concerns :article
    resources :subscribes, only: [:new, :create] do
      collection do
        get :success
        get :fail
      end
    end
  end

  scope module: :market do
    scope module: :knigi do
      resources :books, path: 'market/book' do
        resources :pages, path: 'page', module: :books
        member do
          put "add", to: "books#library"
          put "remove", to: "books#library"
          get :success
          get :fail
        end
      end
      resources :library, path: 'market/library', only:[:index]
    end
  end

  resources :profiles

  get "info/:page" => "static#show"

  root to: "article/categories#index"

end
