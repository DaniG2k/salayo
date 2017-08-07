class Admin::SubscriptionsController < Admin::ApplicationController
  def index
    @subscriptions = Subscription.all
  end
end
