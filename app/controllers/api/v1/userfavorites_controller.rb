class Api::V1::UserfavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user_favorites = UserFavorite.all
    render "index.json.jbuilder"
  end
  def destroy
    user = current_user
    params_favorite = params["url"]
    @user_favorite = UserFavorite.where(favorite_id: params[:id], user_id: current_user.id)
    @user_favorite.destroy
  end
end
