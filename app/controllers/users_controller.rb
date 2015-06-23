class UsersController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])
  end
end
