class ActivateController < ApplicationController
  def create
    user = User.find(params[:id])
    user.update(active?: true)
    redirect_to "/dashboard"
    flash[:success] = "Thank you! Your account is now activated."
  end
end
