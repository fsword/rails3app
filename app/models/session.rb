class Session < ActiveRecord::Base
  attr_accessor :login,:password
  
  belongs_to :user
  
  def self.login login,password
    user = User.auth login, password
    Session.create(:user=> user) if user
  end
end
