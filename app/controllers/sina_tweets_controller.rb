class SinaTweetsController < ApplicationController

#  before_filter :oauth_sina

  def initialize
    api_key = "0ce4a109569fb71726ade31c03df2545"
    api_key_secret = "7d5e9f860747891c"
    @consumer=OAuth::Consumer.new(
      api_key,
      api_key_secret,
      {
        :site=>"http://www.douban.com",
        :request_token_path=>"/service/auth/request_token",
        :access_token_path=>"/service/auth/access_token",
        :authorize_path=>"/service/auth/authorize",
        :signature_method=>"HMAC-SHA1",
        :scheme=>:header,
        :realm=>"http://freebuilder.3322.org:3000"
      }
    )
  end

  def index
    response = access_token.get 'http://api.douban.com/people/%40me'
    render :text => response.body
  end

  def create
    redirect_to sina_tweets_path, :notice => 'success'
  end

  def oauth_sina
    if session[:request_token].nil?
      request_token=@consumer.get_request_token

      session[:request_token] = request_token
      redirect_to request_token.authorize_url+"&oauth_callback=http://localhost:3000/sina_tweets"
    end
  end

  def access_token
    @access_token = OAuth::AccessToken.new(@consumer,'1136c6e889c2b6e633a454b99d4824b2','a0c31192d83eb2ba')
#    @access_token = session[:access_token]
#    if @access_token.nil?
#      session[:access_token] = session[:request_token].get_access_token
#      @access_token = session[:access_token]
#      debugger
#    end
#    @access_token
  end
end
