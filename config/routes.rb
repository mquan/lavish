Lavish::Application.routes.draw do
  root to: 'styles#new'
  resources :styles
  post '/customize' => 'styles#customize', as: :customize
  get '/preview' => "styles#preview", as: :preview
end
