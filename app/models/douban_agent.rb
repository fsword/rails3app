require 'oauth/consumer'
class DoubanAgent < ActiveRecord::Base
  belongs_to :user

  def self.request_by user
    agent = user.douban_agent || self.create( :user => user )
    raise "用户已经开通" unless agent.access_token.nil?
    agent.request_token
  end

  # 获取当前的rquest_token对象，如果没有就创建一个
  def request_token
    return @request if @request
    if request_key.nil?
      @request = DoubanAgent.consumer.get_request_token
      update_attributes :request_key => @request.token, :request_secret => @request.secret
    else
      @request = OAuth::RequestToken.new( DoubanAgent.consumer, request_key, request_secret )
    end
    @request
  end

  # 获取当前的access_token对象，如果没有就返回nil
  def access_token
    @access ||= OAuth::AccessToken.new( DoubanAgent.consumer, access_key, access_secret ) unless access_key.nil?
  end

  # 获取访问授权信息，从这里开始系统就可以提供对用户的服务了
  def authorize
    @access = request_token.get_access_token
    update_attributes :access_key => @access.token, :access_secret => @access.secret
    @access
  end

  def method_missing method, *args
    if access_token
      access_token.send method, *args
    else
      super
    end
  end

  # 获取豆瓣的 concumer
  def self.consumer
    api_key = "0ce4a109569fb71726ade31c03df2545"
    api_key_secret = "7d5e9f860747891c"
    @@consumer ||= OAuth::Consumer.new(
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

end
