class ArticlesController < ApplicationController

  def index 
    if params[:sources] && current_user
      UserSource.where(user_id: current_user.id).destroy_all
      params[:sources].each do |source_id|
        UserSource.create(user_id: current_user.id, source_id: source_id)
        flash[:success] = "Updated sources!"
      end
    end

    if params[:search]
      @articles = Source.where("title ILIKE ?", "%" + params[:search] + "%")
    end

    @news_all = []        
    @all_sources = Source.all.order(:source)  #places the array of hashes of all sources in the db = to variable @all_sources

    @all_sources.each do |source_all| # runs through each source has within the array naming it source_all

      @news_all << source_all[:source]  #shovels each source name into the array of @news_all to be used below as an or statement if no params are met.

    end

    @news = []
    @articles = []
    if current_user
      @user = User.find_by(id: current_user.id)     # returns the user ID

      user_sources = @user.sources || @news_all     # returns all sources associated with that user id (hash)

      user_sources.each do |source|               # runs through each hash as "source"

        @db_source = Source.find_by(source: source.source)        # finds the source in the db based by the source name (source.source) and stores it as @db_source for the favorite button to collect source.id

        result = Unirest.get("https://newsapi.org/v1/articles?source=#{source.source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body   #api that runs through each source adding "source.source" (source name) to the api and stores it as variable result

        @news << result     # every api source is then shuffled in to the @news array
      end
      @news.each do |source|
        source["articles"].each do |article|
          @articles << article
        end
      end
      else
        @sources = params["sources"] || @news_all
        @sources.each do |source|
          @db_source = Source.find_by(source: source)
          result = Unirest.get("https://newsapi.org/v1/articles?source=#{source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
          @news << result
        end
        @news.each do |source|
          source["articles"].each do |article|
            @articles << article
          end
        end
    end
    @news
    render "index.html.erb"
  end
end

