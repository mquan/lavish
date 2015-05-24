Lavish::Application.routes.draw do
  root to: 'bootstrap#new'
  post '/customize' => 'bootstrap#customize', as: :customize
  get '/preview' => "bootstrap#preview", as: :preview
end
