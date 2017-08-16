class RoommatesController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def ads
    @advertisements = Advertisement.all.includes(:user)
  end
end
