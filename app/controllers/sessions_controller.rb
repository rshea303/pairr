class SessionsController < ApplicationController
  before_action :authorize!, only: [:destroy]

  def create
    if User.exists?(uid: request.env['omniauth.auth'].uid)
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])

      if user
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        redirect_to root_path
      end

    else
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      if user
        session[:user_id] = user.id
        redirect_to edit_user_path(user)
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
