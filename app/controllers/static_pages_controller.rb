class StaticPagesController < ApplicationController
  def home
  end

  def dashboard
  end

  def pairs
    @user = User.find(10)
  end
end
