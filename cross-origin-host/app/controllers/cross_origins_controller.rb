class CrossOriginsController < ApplicationController
  before_action :allow_cors, only: [:set_data_to_cookie, :get_data_from_cookie]

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
    cookies[key] = cookies[:name] = {
      value: value,
      expires: 1.year.from_now,
      domain: %w(http://localhost:3000 http://localhost:3001),
      secure: true,
    }
    render json: { message: 'Set key successfully' }, status: 200
  end

  # GET
  def get_data_from_cookie
    key = params[:key]
    render json: { value: cookies[key] }, status: 200
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def allow_cors
    # Only accept CORS from holistics website or when in development
    if request.headers['Origin'] == 'http://localhost:3001'
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin']
      response.headers['Access-Control-Allow-Credentials'] = 'true'
      response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
  end
end
