class SessionsController < ApplicationController

  skip_before_filter :login_required

  def new
    @session = Session.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session }
    end
  end

  def destroy
    @session = Session.find(session[:curr_session])
    @session.destroy if @sessin
    session[:curr_session]=nil
    flash[:notice] = "Successfully logged out."
    redirect_to login_path, :format => params[:format]
  end

  def create
    user = User.auth(params[:session][:login],params[:session][:password])
    
    respond_to do |format|
      if user
        @session = Session.create(:user=>user)
        session[:curr_session] = @session.id
        format.html { redirect_to( '/', :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
