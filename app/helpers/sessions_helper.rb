module SessionsHelper

  def sign_in(user)
  	cookies.permanent[:remember_token] = user.remember_token
  	self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def has_relationship?(profile_id, user_id)
    Relationship.exists?(:profile_id => profile_id, :user_id => user_id)
  end

  def is_invited?(token)
    Invitation.exists?(:token => token)
  end

  def is_a_user_already?(email)
    User.find_by_email(email)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in"
    end
  end

  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end