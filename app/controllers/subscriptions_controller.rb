class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  
  def index
    @subscriptions = Subscription.all
  end
end
