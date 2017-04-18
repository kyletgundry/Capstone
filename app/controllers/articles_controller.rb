class ArticlesController < ApplicationController

  def index
    @news_all = []
    sources = Source.all
    sources.each do |source_all|
      @news_all << source_all[:source]
    end
    @user = User.find_by(id: current_user.id)
    @news = []
    if current_user
      @user.sources.each do |source|
        result = Unirest.get("https://newsapi.org/v1/articles?source=#{source.source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
        @news << result
      end
    else
      @sources = params["sources"] || @news_all
        @sources.each do |source|
          result = Unirest.get("https://newsapi.org/v1/articles?source=#{source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
          @news << result
        end
    end
    @news
    render "index.html.erb"
  end

  def update

  end
end
