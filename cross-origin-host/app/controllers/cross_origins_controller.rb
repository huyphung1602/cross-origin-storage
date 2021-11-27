class CrossOriginsController < ApplicationController
  content_security_policy do |policy|
    policy.frame_ancestors :self, 'localhost:3000', 'localhost:3001'
  end

  def storage
    render 'cross_origins/cross_origin_storage', layout: false
  end
end
