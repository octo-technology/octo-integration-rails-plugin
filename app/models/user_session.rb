class UserSession < Authlogic::Session::Base
  
  def validate_by_openid
    self.remember_me = controller.params[:remember_me] == "true" if controller.params.key?(:remember_me)
    controller.send(:authenticate_with_open_id, openid_identifier, :return_to => controller.url_for(:for_session => "1", :remember_me => remember_me?)) do |result, openid_identifier|
      if result.unsuccessful?
        errors.add_to_base(result.message)
        return
      end
      
      self.attempted_record = klass.send(find_by_openid_identifier_method, openid_identifier)
      
      if !attempted_record
        self.attempted_record = klass.create :openid_identifier => openid_identifier
      end
    end
  end
  
end