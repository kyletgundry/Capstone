class Api::V1::UserSourcesController < ApplicationController
  def index
    @usersources = UserSource.all
    render "index.json.jbuilder"
  end
  def create
    user_source = UserSource.new(
      user_id: current_user.id,
      source_id: params[:source_id]
      )
    if user_source.save
      flash[:success] = 'Successfully Saved Source!'
    end
    redirect_to :back
  end

end
