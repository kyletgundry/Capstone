class ArticlesController < ApplicationController

  def index
    @news = []

    @sources = params["sources"]
      @sources.each do |source|
        result = Unirest.get("https://newsapi.org/v1/articles?source=#{source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
        @news << result
      end
    @news
    render "index.html.erb"
  end
end
