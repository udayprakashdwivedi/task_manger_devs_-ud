class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: "User registered successfully", user: resource }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def set_flash_message!(*)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :status)
  end
end
