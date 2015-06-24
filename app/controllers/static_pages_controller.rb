class StaticPagesController < ApplicationController
  def home
  end

  def dashboard
  end

  def pairs
    require "pry"
    binding.pry
    @user = User.last
  end
end
