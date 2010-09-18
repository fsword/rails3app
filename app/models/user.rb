class User < ActiveRecord::Base
  def self.auth login, password
    self.where(:name => login, :password => password).first
  end
end
