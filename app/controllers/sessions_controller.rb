class SessionsController < ApplicationController
  
  skip_filter :authenticate, :only => [:confirm]
    

  def logout
    session.clear
    redirect_to root_url
  end
  
  def new
    render :layout => false
  end
  
  def confirm
    if request.post?
      @user = User.new params[:user]
      if @user.save
        set_current_user @user.id
        redirect_to root_path
      end
    else
      @user = User.new session[:signup]
      @user.nickname = @user.email.split("@").first if @user.email.present?
    end
  end
  
end