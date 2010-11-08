module ApplicationHelper
  def current_user
    Session.find( session[:curr_session] ).user
  end
end
