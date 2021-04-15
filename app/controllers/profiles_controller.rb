class ProfilesController < ApplicationController
  def index
  end

  def new
    @profiles = Profile.find_by(user_id: current_user.id)
  end
  
  def create
    @profiles = Profile.new(profileparams)
    if @profiles.save(profileparams)
      redirect_to root_path
    else
    end
  end
  
  def update
    @profiles = Profile.find_by(user_id: current_user.id)
    if @profiles.update(profileparams)
      redirect_to root_path
    else
    end
  end
  
  private
  def profileparams
    params.permit(:user_id,:postalcode,:city,:adress,:building,:sei_kana,:sei_kanzi,:mei_kana,:mei_kanzi,:tel)
  end
end
