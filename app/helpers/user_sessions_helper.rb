module UserSessionsHelper
  
  def application_name
    ENV["APPLICATION_NAME"] || "Your application name"
  end
end