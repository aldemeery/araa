class OpinionsController < ApplicationController
  include SessionsHelper

  before_action :require_login

  def create
    @opinion = @logged_user.opinions.new(opinion_params)

    if @opinion.save
      redirect_to root_path
    else
      redirect_back fallback_location: root_path, alert: 'Failure.'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
