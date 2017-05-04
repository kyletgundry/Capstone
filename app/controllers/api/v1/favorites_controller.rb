class Api::V1::FavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @favorites = Favorite.all
    render "index.json.jbuilder"
  end

  def create
    @favorite = Favorite.new(
      url: params[:url],
      user_id: current_user.id
      )
    # if @favorite.save
      # flash[:success] = 'Successfully favorited article!'
      # redirect_to :back
    # end
    @favorite.save
    render "show.json.jbuilder"
    # redirect_to :back
  end

  def destroy
    user = current_user
    params_favorite = params["url"]
    @favorite = UserFavorite.where(url: params[:url], user_id: current_user.id)
    @favorite.destroy
  end

end
