class ApplicationController < ActionController::Base
  protect_from_forgery


  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user, :currently_signed_in?, :current_user_signed_in?

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
