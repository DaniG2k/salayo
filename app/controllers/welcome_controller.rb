class WelcomeController < ApplicationController
  before_action :set_top_bar_transparency

  def index
    @subscribe_email = Subscription.new
  end

  def subscribe
    @subscribe_email = Subscription.new(subscription_params)

    if @subscribe_email.save
      flash[:success] = I18n.t('.thanks_for_subscribing')
      redirect_to root_path(anchor: 's_form')
    else
      render :index
    end
  end

  def privacy_policy; end

  def terms; end

  private

  def subscription_params
    params.require(:subscription).permit(:email)
  end

  def set_top_bar_transparency
    @top_bar_transparent = %w[index subscribe].include?(action_name)
  end
end
