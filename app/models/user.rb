class User < ActiveRecord::Base
  add_oauth

  has_one :profile

  has_many :sessions

  def self.auth login, password
    self.where(:name => login, :password => password).first
  end
end
