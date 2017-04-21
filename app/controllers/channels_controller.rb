class ChannelsController < ApplicationController
  def show
    @message = Message.new
    @channel = Channel.find(params[:id])
    @messages = @channel.messages
    @channels = current_user.channels.uniq
    session[:user_ids] = [current_user.id]
  end

  def new
    @channel = Channel.new
    session[:user_ids] << select_params[:user_id] if params["selected_user"]
    @selected_users = User.selected_users(session[:user_ids])
    @users = params["search_user"] ? User.pgsearch(search_params[:name]) : current_user.friends
  end

  def create
    @channel = Channel.new(channel_params)
    @selected_users = User.selected_users(session[:user_ids])
    if @channel.save
      Subscription.create(  channel: @channel,
                            user: current_user,
                            admin: true)
      @selected_users.each do |user|
        Subscription.create(channel: @channel,
                            user: user)
      end
      redirect_to @channel
    else
      @users = current_user.friends
      render :new
    end
  end

  def delete_selected_user
    session[:user_ids].delete(params[:id])
    redirect_to new_channel_path
  end

  private

  def search_params
    params.require(:search_user).permit(:name)
  end

  def select_params
    params.require(:selected_user).permit(:user_id)
  end

  def channel_params
    params.require(:channel).permit(:name)
  end

end
