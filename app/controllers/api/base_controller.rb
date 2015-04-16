class Api::BaseController < ApplicationController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  respond_to :json

  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = User.find_by_email(user_email) if user_email

    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    else
      render :json => {success: false, message: "Authentication failed."}, status: 401 and return
    end
  end

  protected

  def render_error(status, err = 'Something went wrong')
    render :json => {success: false, message: err}, status: status
  end

end