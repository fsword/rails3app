class DoubanObserver < ActiveRecord::Observer
  observe :profile

  def after_update profile
    douban_agent = profile.user.douban_agent
    if douban_agent && douban_agent.access_token
      douban_agent.access_token.post "http://api.douban.com/miniblog/saying", %Q{<?xml version='1.0' encoding='UTF-8'?><entry xmlns:ns0="http://www.w3.org/2005/Atom" xmlns:db="http://www.douban.com/xmlns/"><content>#{profile.self_desc}</content></entry>},  {"Content-Type" =>  "application/atom+xml"}
    end
  end
end
