class SessionsController < ApplicationController

  def logout
    session.clear
    redirect_to root_url
  end
  
end