Lavish::Application.routes.draw do
  root :to => 'styles#new'
  resources :styles
  match '/customize' => 'styles#customize', :as => :customize
end
