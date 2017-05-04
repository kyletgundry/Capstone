class Api::V1::UserSourcesController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def destroy
    user = current_user
    params_source = params[:source_id].to_i
    p "________________________"
    p user
    p params[:source_id]
    usersource = UserSource.where(source_id: params_source, user_id: user.id)
    p "________________________"
    p usersource
    p "________________________"
    usersource.each do |sourcedelete|
      p sourcedelete
      sourcedelete.destroy
    end
  end
end
