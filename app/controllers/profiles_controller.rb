class ProfilesController < ApplicationController
  def show
    @user=User.find(params[:user_id])
  end

  def edit
    @user=User.find(params[:user_id])
  end

  def update
    @user=User.find(params[:user_id])
    user_params=params.require(:user).permit(:bio, :hometown)
    @user.update_attributes(user_params)
    render :show
  end
end
