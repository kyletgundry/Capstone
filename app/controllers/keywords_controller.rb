class KeywordsController < ApplicationController

  def destroy
    @keyword = Keyword.find_by(id: params[:id])
    @keyword.destroy
    redirect_to "/users/#{current_user.id}"
  end

end
