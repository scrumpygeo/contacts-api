class V1::SessionsController < ApplicationController
  def show 
    # this is for endpoint to allow verification user signed in .
    current_user ? head(:ok) : head(:unauthorized)
  end

  def create 
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      render :create, status: :created  # renders created view and returns 201 status
    else
      head(:unauthorized)
    end
  end

  def destroy 
    current_user&.authentication_token = nil
    if current_user.save 
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end