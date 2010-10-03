class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to '/' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
