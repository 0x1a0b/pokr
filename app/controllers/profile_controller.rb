class ProfileController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user

  def show

  end

  def update
    if @user.update profile_params
      remove_guest_and_reset_password if guest_user_updated_email?(@user.email)
      redirect_to profile_path, flash: { success: "Your profile updated successfully, we'll send you an email to reset your password" }
    else
      render :show
    end
  end

  def update_password
    if guest_user?
      set_user_password
    else
      update_user_password
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params[:user][:name] = params[:user][:name][0..20]
    user_params = [:name, :avatar]
    user_params << :email if guest_user?

    params.require(:user).permit(*user_params)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def update_user_password
    if @user.valid_password? params[:user][:current_password]
      set_user_password
    end
  end

  def set_user_password
    if @user.update(password_params) # Sign in the user by passing validation in case their password changed
      bypass_sign_in @user
      redirect_to profile_path, flash: { success: 'Your password updated successfully' }
    else
      render :show
    end
  end

  def remove_guest_and_reset_password
    remove_guest_user
    reset_guest_password
  end

  def reset_guest_password
    current_user.send_reset_password_instructions
  end

  def guest_user_updated_email? email
    guest_user? && !(email =~ /@pokrex.com\z/)
  end
end
