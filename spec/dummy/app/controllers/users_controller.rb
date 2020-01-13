class UsersController < ApplicationController
  def index
    if current_user
      render json: current_user, status: 200
    else
      render json: { error: 'unauthorized' }, status: 401
    end
  end
end
