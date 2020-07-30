Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' ,to:'welcome#root' ,as: :root

  resources:posts

  resources:users ,only: [:new, :create]

  resources:session,only: [:new, :create, :destroy]
end
