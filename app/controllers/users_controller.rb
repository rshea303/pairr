class UsersController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])
    @languages = Language.all
  end

  def update
    user = User.find_by(id: params[:id])
    languages = Language.find_by
    if user.update(user_params) 
      redirect_to edit_path_user(user)
    else
      render :edit
    end
  end
end
