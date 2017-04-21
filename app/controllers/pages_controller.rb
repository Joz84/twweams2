class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @channel = Channel.first
  end

  private

  # def channel_params
  #   params.require(:channel).permit(:birthdate, :male, :female)
  # end
end
