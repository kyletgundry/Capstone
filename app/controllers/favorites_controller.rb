class FavoritesController < ApplicationController
  
  def create
    favorite = Favorite.new(
      source_id: params[:source_id],
      url: params[:url]
      )
    if favorite.save
      flash[:success] = 'Successfully favorited article!'
      redirect_to :back
    end
    user_favorite = UserFavorite.new(
      user_id: current_user.id,
      favorite_id: favorite.id
      )
    user_favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(id: params[:id])
    @favorite.destroy
    redirect_to "/users/#{current_user.id}"
  end
end
