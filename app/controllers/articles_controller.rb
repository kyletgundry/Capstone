class ArticlesController < ApplicationController

  def index 
    if params[:sources] && current_user
      UserSource.where(user_id: current_user.id).destroy_all
      params[:sources].each do |source_id|
        UserSource.create(user_id: current_user.id, source_id: source_id)
        flash[:success] = "Updated sources!"
      end
    end

    @news_all = []
    @all_sources = Source.all.order(:source)
    @all_sources.each do |source_all|
      @news_all << source_all[:source]
    end
    @news = []
    if current_user
      @user = User.find_by(id: current_user.id)
      user_sources = @user.sources || @news_all
        user_sources.each do |source|
          @db_source = Source.find_by(source: source.source)
          result = Unirest.get("https://newsapi.org/v1/articles?source=#{source.source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
          @news << result
        end
    else
      @sources = params["sources"] || @news_all
        @sources.each do |source|
          @db_source = Source.find_by(source: source)
          result = Unirest.get("https://newsapi.org/v1/articles?source=#{source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
          @news << result
        end
    end
    @news
    render "index.html.erb"
  end

  # def favorite
  #   type = params[:type]
  #   if type == "favorite"
  #     current_user.favorites << @article
  #     redirect_to :back, notice: "You favorited!"

  #   elsif type == "unfavorite"
  #     current_user.favorites.delete(@article)
  #     redirect_to :back, notice: "Unfavorited!"
  #   else
  #     redirect_to :back, notice: 'Nothing happened.'
  #   end
  # end

  # def update
  #   @user = User.find_by(id: current_user.id)
  #   @user.sources.update(
  #   source: params[:sources]
  #   )
  #   @user.save
  # end

end

