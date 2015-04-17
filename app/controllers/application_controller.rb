class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    respond_to do |format|
      format.html{
        flash[:error] = "You're not authorized to do so."
        redirect_to root_url
      }
      format.json{
        render :json => {success: false, message: "Authorization failed."}, status: 401
      }
    end   
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
