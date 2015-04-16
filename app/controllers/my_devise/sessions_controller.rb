class MyDevise::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  skip_before_action :verify_signed_out_user
  respond_to :json
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.html{
        super
      }
      format.json{
        user = User.find_for_database_authentication({email: params[:user][:email]})
        return invalid_login_attempt unless user

        if user.valid_password?(params[:user][:password])
          user.set_authentication_token!
          render :json => {success: true, user: {email:user.email, authentication_token: user.authentication_token}}, status: :created
        else
          invalid_login_attempt
        end        
      }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    respond_to do |format|
      format.html{
        super
      }
      format.json{
        user_email = request.headers["X-API-EMAIL"].presence
        user_auth_token = request.headers["X-API-TOKEN"].presence
        user = User.find_by_email(user_email) if user_email
        if user && Devise.secure_compare(user.authentication_token, user_auth_token)
          user.clear_authentication_token!
          render :json => {success: true, message: "User Logged out"} , status: 200
        else
          render :json => { success: false, message: "Invalid token or email"}, status: 401
        end
      }
    end
  end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def invalid_login_attempt
    warden.custom_failure!
    render :json => {success: false, message: "Error with your email or password"}, status: 401
  end
end
