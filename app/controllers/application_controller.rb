class ApplicationController < ActionController::Base
  protect_from_forgery


  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user, :currently_signed_in?, :current_user_signed_in?
  
  def ensure_that_signed_in 
  redirect_to signin_path, :notice => 'you should be signed in' if current_user.nil?
end


def ensure_that_is_admin
  redirect_to signin_path, :notice => "you should be admin" if current_user.is_admin? == false
end

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def currently_signed_in?(user)
    current_user == user
  end

  def current_user_signed_in?
    if not current_user.nil?
      currently_signed_in? current_user
    else
      false
    end
  end
end
