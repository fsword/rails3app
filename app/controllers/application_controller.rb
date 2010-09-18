class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required
  
  def login_required
    unless session[:curr_session]
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
    end
  end
end
