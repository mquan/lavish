Lavish::Application.routes.draw do
  root :to => 'styles#set'
  match '/customize' => 'styles#customize', :as => :customize
end
