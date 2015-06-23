class UsersController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])
    @languages = Language.all
  end

  def update
    user = User.find_by(id: params[:id])

    if params[:language_ids]
      language_ids = params[:language_ids].values
      language_ids.each do |id|
        user.languages << Language.find(id)
      end
      user.save

      if user.description.nil?
        flash[:alert] = "Please complete the description"
        redirect_to edit_user_path(user)
      else
        flash[:notice] = "Let's get pairing"
        redirect_to dashboard_path
      end
    else
      new_description = params[:description]
      user.description = new_description
      user.save
      
      if user.languages.nil?
        flash[:alert] = "Please select some languages"
        redirect_to edit_user_path(user)
      else
        flash[:notice] = "Let's get pairing"
        redirect_to dashboard_path
      end
    end

  end
end
