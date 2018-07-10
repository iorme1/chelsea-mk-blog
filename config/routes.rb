Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  resources :posts do
    collection do
      get :draft 
    end
    resources :comments, only: [:create, :destroy, :edit, :update]
  end


  root 'posts#index'
end
