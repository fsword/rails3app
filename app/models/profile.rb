class Profile < ActiveRecord::Base
  belongs_to :user

  def after_update
    if self.user.douban?
      user.douban.post "http://api.douban.com/miniblog/saying", %Q{<?xml version='1.0' encoding='UTF-8'?><entry xmlns:ns0="http://www.w3.org/2005/Atom" xmlns:db="http://www.douban.com/xmlns/"><content>#{self_desc}</content></entry>},  {"Content-Type" =>  "application/atom+xml"}
    end
  end
end
