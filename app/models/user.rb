class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end

  def attributes_to_save
    {}
  end

  def trigram
    openid_identifier.split('/').last
  end

end