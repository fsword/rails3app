require 'oauth/consumer'
class SinaTweetsController < ApplicationController

  before_filter :oauth_sina

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
    @response = access_token.post "http://api.douban.com/miniblog/saying",
      %Q{<?xml version='1.0' encoding='UTF-8'?>
<entry xmlns:ns0="http://www.w3.org/2005/Atom" xmlns:db="http://www.douban.com/xmlns/">
<content>今天试验一下 oauth  #{Time.now}</content>
</entry>},  {"Content-Type" =>  "application/atom+xml"}
    render :text => @response.body
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
    @access_token = session[:access_token]
    if @access_token.nil?
      @access_token = session[:request_token].get_access_token
      session[:access_token] = @access_token
    end
    @access_token
  end
end
