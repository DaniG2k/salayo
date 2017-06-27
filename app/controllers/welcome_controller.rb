class WelcomeController < ApplicationController
  def index
    @register_email = Registration.new
  end

  def register
    @register_email = Registration.new(registration_params)

    if @register_email.save
      redirect_to root_path(anchor: 'subscribe'), notice: 'Thanks for subscribing!'
    else
      render :index
    end
  end

  private
    def registration_params
      params.require(:registration).permit(:email)
    end
end
