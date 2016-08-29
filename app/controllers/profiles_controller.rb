class ProfilesController < ApplicationController

  before_action :find_user, only: [:show, :edit]

  def show
  end

  def edit
  end

  def update
    @user.update()
  end

  private

  def find_user
    @user = User.find(params[:id])
  end


end
