class Api::V1::KeywordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @keywords = Keyword.all
    render "index.json.jbuilder"
  end

  def create
    @keyword = Keyword.new(
      keyword: params["keyword"],
      user_id: current_user.id
      )
    @keyword.save
  end

  def destroy
    @keyword = Keyword.find_by(user_id: current_user.id, keyword: params[:keyword])
    @keyword.destroy
  end 
end
