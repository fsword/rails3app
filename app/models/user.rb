class User < ActiveRecord::Base

  has_one :profile
  has_one :douban_agent

  has_many :sessions

  def self.auth login, password
    self.where(:name => login, :password => password).first
  end
end
