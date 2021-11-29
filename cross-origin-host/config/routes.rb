Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'cross_origin_storage', to: 'cross_origins#storage'

  get 'set_data_to_cookie', to: 'cross_origins#set_data_to_cookie'
  get 'get_data_from_cookie', to: 'cross_origins#get_data_from_cookie', format: :json
end
