class CrossOriginsController < ApplicationController
  content_security_policy do |policy|
    policy.frame_ancestors :self, 'localhost:3000', 'localhost:3001'
  end

  def storage
    render 'cross_origins/cross_origin_storage', layout: false
  end

  # POST
  def set_data_to_cookie
    key = params[:key]
    value = params[:value]
    cookies[key] = value
    render json: { message: 'Set key successfully' }, status: 200
  end

  # GET
  def get_data_from_cookie
    key = params[:key]
    render json: { value: cookies[key] }, status: 200
  end
end
