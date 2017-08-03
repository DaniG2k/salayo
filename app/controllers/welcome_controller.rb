class WelcomeController < ApplicationController
  def index
    @subscribe_email = Subscription.new
  end

  def subscribe
    @subscribe_email = Subscription.new(subscription_params)

    if @subscribe_email.save
      flash[:success] = "Thanks for subscribing. We'll let you know when we officially go live."
      redirect_to root_path(anchor: 's_form')
    else
      render :index
    end
  end

  private
    def subscription_params
      params.require(:subscription).permit(:email)
    end
end
