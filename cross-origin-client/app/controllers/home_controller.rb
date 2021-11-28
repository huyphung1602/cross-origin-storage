class HomeController < ApplicationController
  content_security_policy do |policy|
    policy.frame_src :self, :https, 'localhost:3000'
    policy.connect_src :self, 'localhost:3000'
  end

  def show
  end
end
