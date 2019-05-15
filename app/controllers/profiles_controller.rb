class ProfilesController < ApplicationController
  def show
    @user=current_user
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    user_params=params.require(:user).permit(:bio, :hometown)
    @user.update_attributes(user_params)
    render :show
  end
end
