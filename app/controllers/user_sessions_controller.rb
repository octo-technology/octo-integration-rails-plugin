class UserSessionsController < ApplicationController
  
  before_filter :check_if_octo_only, :only => :create
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy


  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        flash[:notice] = t(:login_flash)
        redirect_back_or_default account_url
      else
        render :action => :new
      end
    end
  rescue 
    render :action => :new
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t(:logout_flash)
    redirect_back_or_default new_user_session_url
  end
  
  def check_if_octo_only
    if ENV['OCTO_OPEN_ID'] && params[:user_session]
      params[:user_session][:openid_identifier] = "https://openid.octo.com/users/" + params[:user_session][:openid_identifier] 
    end
    
  end
end
