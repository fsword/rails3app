class OauthController < ApplicationController
  def initialize
  end
    
  def douban
    begin
      request_token = DoubanAgent.request_by current_user
      redirect_to request_token.authorize_url+"&oauth_callback=http://localhost:3000/oauth/accept"
    rescue Exception => e
      render :text => e.message
    end
  end

  def accept
    debugger
    current_user.douban_agent.authorize
    redirect_to '/'
  end
end
