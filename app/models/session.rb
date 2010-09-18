class Session < ActiveRecord::Base
  attr_accessor :login,:password
  
  belongs_to :user
end
