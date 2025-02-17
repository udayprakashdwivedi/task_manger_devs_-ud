class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def refresh_token
    user = User.find_by(refresh_token: params[:refresh_token])

    if user
      new_access_token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

      render json: {
        message: "Token refreshed successfully",
        access_token: new_access_token
      }, status: :ok
    else
      render json: { error: "Invalid refresh token" }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    access_token = request.env["warden-jwt_auth.token"]
    refresh_token = resource.generate_refresh_token

    resource.update(refresh_token: refresh_token)

    render json: {
      message: "Login successful",
      user: resource,
      access_token: access_token,
      refresh_token: refresh_token
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      current_user.update(refresh_token: nil)
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def set_flash_message!(*)
  end

  def require_no_authentication
  end
end
