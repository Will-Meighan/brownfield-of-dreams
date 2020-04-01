class InvitesController < ApplicationController
  def new
  end

  def create
    # require "pry"; binding.pry
    # current_user

    redirect_to '/dashboard'
  end
end
