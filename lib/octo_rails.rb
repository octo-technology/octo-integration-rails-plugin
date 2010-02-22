# Octo
module OctoRails
  
  def self.included base
    base.send :helper_method, :current_user
  end
  
  def authenticate opts={}
    return true if session[:user]
    if resp = request.env["rack.openid.response"]
      if resp.status == :success
        set_current_user resp
        redirect_after_auth
      else
        flash[:error] = "OpenID result: #{resp.status}"
        render "/sessions/new" unless session[:user]
      end
    else
      unless params[:openid_identifier].blank?
        params[:openid_identifier] = "https://openid.octo.com/users/" + params[:openid_identifier] if ENV['OCTO_OPEN_ID']
        response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(:identifier => params["openid_identifier"], :required => ['email', "http://axschema.org/contact/email"])
        render :text => 'got openid?', :status => 401
      else
        session[:after_login_url] = request.env['REQUEST_URI']
        unless session[:user]
          render "/sessions/new"
        end
      end
    end
  end
  
  def redirect_after_login_url
    if session.has_key? :after_login_url
      redirect_to session[:after_login_url]
      session[:after_login_url] = nil
    else
      redirect_to projects_url
    end
  end
  
  def set_current_user resp
    email = resp.get_signed "http://openid.net/srv/ax/1.0", "value.ext0"
    begin
      user = User.find_by_openid!(resp.display_identifier)
      user.update_attribute :email, email if user.email.blank? && email
    rescue ActiveRecord::RecordNotFound
      user = User.create :openid => resp.display_identifier, :email => email
      session[:first_connection] = true
    end
    session[:user] = user.id
  end
  
  protected
  def redirect_after_auth
    if session.has_key? :first_connection
      redirect_to :controller => :users, :action => :first_connection
      return
    end
    redirect_after_login_url
  end
  
  def current_user
    @current_user ||= User.find session[:user]
  end

end