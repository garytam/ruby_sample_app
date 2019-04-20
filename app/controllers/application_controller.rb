class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper #### -> to include the sessionHelper to all controllers
end
