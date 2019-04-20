module SessionsHelper

  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id  # creates a temp cookie and encrypt user.id
  end

  #return the current login user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Return true if user is logged in, else false
  def log_in?
    #debugger
    !current_user.nil?
  end

  # Log out the current user
  def log_out
    session.delete(:user_id)
    # session[:user_id] = null
    @current_user = nil
  end
end
