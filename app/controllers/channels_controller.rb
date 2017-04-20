class ChannelsController < ApplicationController
  def show
    @message = Message.new
    @channel = Channel.find(params[:id])
    @messages = @channel.messages
    @channels = current_user.channels
    session[:new_channel] = [current_user.id]
  end

  def new
    # session[:new_channel] = [current_user.id] unless session[:new_channel]
    session[:new_channel] << select_params[:user_id] if params["selected_user"]
    @selected_users = User.where(id: session[:new_channel]).reverse
    if params["search_user"]
      @users = User.pgsearch(search_params[:name])
    else
      @users = current_user.users.select{ |user| user != current_user}
    end
  end

  def delete_selected_user
    session[:new_channel].delete(params[:id])
    redirect_to new_channel_path
  end

  def search_params
    params.require(:search_user).permit(:name)
  end

  def select_params
    params.require(:selected_user).permit(:user_id)
  end


end
