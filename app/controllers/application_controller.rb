class ApplicationController < ActionController::Base

  def sign_in(user)
    remember_token = SecureRandom.urlsafe_base64
    remember_digest = Digest::SHA1.hexdigest(remember_token)
    user.update_attribute(:remember_token, remember_digest)
    cookies.permanent[:remember_token] = remember_token
  end

  def current_user
    if cookies[:remember_token]
      user_digest = Digest::SHA1.hexdigest(cookies[:remember_token])
      @user ||= User.find_by(remember_token: user_digest)
    end
  end

  def sign_out
    cookies.delete(:remember_token)
    @user = nil
  end

  def signed_in?
    !current_user.nil?
  end
end
