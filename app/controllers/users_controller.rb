class UsersController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])
    @languages = Language.all
  end

  def update
    require "pry"
    binding.pry
  end
end
