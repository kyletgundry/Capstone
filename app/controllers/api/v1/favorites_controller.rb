class Api::V1::FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    render "index.json.jbuilder"
  end

  def create
    favorite = Favorite.new(
      url: params[:url]
      )
    if favorite.save
      flash[:success] = 'Successfully favorited article!'
    end
    user_favorite = UserFavorite.new(
      user_id: current_user.id,
      favorite_id: favorite.id 
      )
    user_favorite.save
    redirect_to :back
  end
end