Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'cross_origin_storage', to: 'cross_origins#storage'
end
