class SubscriptionsController < ApplicationController
  before_action :find_channel, only: [:create, :destroy]

  def create
    @user = User.find(select_params[:user_id])
    Subscription.create(user: @user, channel: @channel)
    redirect_to edit_channel_path(@channel)
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @messages = @channel.messages.where(user: @subscription.user)
    @subscription.destroy
    @messages.destroy_all
    redirect_to edit_channel_path(@channel)
  end

  private

  def find_channel
    @channel = Channel.find(params[:channel_id])
  end

  def select_params
    params.require(:selected_user).permit(:user_id)
  end

end
