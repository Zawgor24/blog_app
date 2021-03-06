# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
  before_action :add_authorize, only: %i[edit update]

  after_action :verify_authorized, only: %i[update edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def add_authorize
    authorize @user
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :age, :avatar)
  end
end
