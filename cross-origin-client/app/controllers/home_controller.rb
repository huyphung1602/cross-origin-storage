class HomeController < ApplicationController
  content_security_policy do |policy|
    policy.frame_ancestors :self, 'localhost:3000', 'localhost:3001'
  end

  def show
  end
end
