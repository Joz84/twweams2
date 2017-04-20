class MessagesController < ApplicationController
  def create
    @channel = Channel.find(params[:channel_id])
    @message = Message.new( user: current_user,
                            channel: @channel,
                            content: message_params[:content]
                          )
    if @message.save
      redirect_to @channel
    else
      @messages = @channel.messages
      @channels = current_user.channels
      render 'channels/show'
    end
  end

  def delete
    raise
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end