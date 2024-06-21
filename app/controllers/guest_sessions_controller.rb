class GuestSessionsController < ApplicationController
  def create
    session[:guest_user] = true
    redirect_to posts_path, notice: "You are now viewing as a guest user."
  end
end
