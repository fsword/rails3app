class User < ActiveRecord::Base

  has_many :sessions

  def self.auth login, password
    self.where(:name => login, :password => password).first
  end
end
