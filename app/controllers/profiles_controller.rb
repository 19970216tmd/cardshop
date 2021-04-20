class ProfilesController < ApplicationController
  def index; end

  def new
    @profiles = Profile.find_by(user_id: current_user.id)
  end

  def create
    @profiles = Profile.new(profileparams)
    redirect_to root_path if @profiles.save(profileparams)
  end

  def update
    @profiles = Profile.find_by(user_id: current_user.id)
    redirect_to root_path if @profiles.update(profileparams)
  end

  private

  def profileparams
    params.permit(:user_id, :postalcode, :city, :adress, :building, :sei_kana, :sei_kanzi, :mei_kana, :mei_kanzi, :tel)
  end
end
