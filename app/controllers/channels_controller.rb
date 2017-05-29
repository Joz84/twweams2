class ChannelsController < ApplicationController
  before_action :find_channel, only:        [:show, :edit, :update, :destroy]
  before_action :find_subscriptions, only:  [:show, :edit, :update]
  before_action :find_admin, only:          [:show, :edit, :update]
  before_action :find_users, only:          [:new,  :edit, :update]

  def show
    @subscription = Subscription.find_by(user: current_user, channel: @channel)
    @new_messages_limit = @subscription.new_messages_limit
    @subscription.update( last_message: @channel.messages.last)
    @message = Message.new
    session[:user_ids] = [current_user.id]
    current_user.update(last_channel: @channel)
  end

  def new
    @channel = Channel.new
    session[:user_ids] << select_params[:user_id] if params["selected_user"]
    @selected_users = User.selected_users(session[:user_ids])
  end

  def first_connection
    @first_subscription = Subscription.new(channel: Channel.first, user: current_user)
    if @first_subscription.save
      @channel = Channel.new({name: ""})
      selected_users = User.selected_users([current_user.id, User.first.id])
      @channel.init(selected_users, current_user)
      redirect_to @channel
    else
      redirect_to current_user.last_channel
    end
  end

  def create
    @channel = Channel.new(channel_params)
    selected_users = User.selected_users(session[:user_ids])
    if selected_users.size > 1 && @channel.save
      @channel.init(selected_users, current_user)
      redirect_to @channel
    else
      @users = current_user.friends
      render :new
    end
  end

  def edit
  end

  def update
    if @channel.update(channel_params)
      redirect_to edit_channel_path(@channel)
    else

      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to Channel.first
  end

  def delete_selected_user
    session[:user_ids].delete(params[:id])
    redirect_to new_channel_path
  end

  private

  def find_channel
    @channel = Channel.find(params[:id])
  end

  def find_subscriptions
    @subscriptions = !@channel.one_to_one? ? @channel.subscriptions : []
  end

  def find_admin
    @admin = @channel.subscriptions.find_by(user: current_user).admin
  end

  def find_users
    @users = params["search_user"] ? User.pgsearch(search_params[:name]) : current_user.friends
  end

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
