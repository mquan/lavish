Lavish::Application.routes.draw do
  root :to => 'styles#new'
  resources :styles
  match '/customize' => 'styles#customize', :as => :customize
  match '/preview' => "styles#preview", as: :preview
end
