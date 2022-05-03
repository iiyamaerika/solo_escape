Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root 'homes#top'
    get '/top' =>  'homes#top'
    get '/about' => 'homes#about'
    get "/diagnosis" => "homes#diagnosis", as: 'diagnosis'
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'
      get 'calendar', to: 'users#calendar', as: 'calendar'
      get 'timeline', to: 'users#timeline', as: 'timeline'
      get 'diet', to: 'users#diet', as: 'diet'
    end
    resources :articles, only: [:index, :show, :edit, :new, :create, :destroy, :update] do
      resource :favorites, only: [:create, :destroy, :show]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :notifications, only: [:index, :destroy]
    resources :chats, only: [:index, :show, :create]
    resources :events
    resources :diets
  end

  # 問い合わせ
  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'


end
