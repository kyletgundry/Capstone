class Api::V1::ArticlesController < ApplicationController
  def index
    @news_api_sources = []
    @articles = []
    sources = Source.all
    sources.each do |source|
      result = Unirest.get("https://newsapi.org/v1/articles?source=#{source.source}&sortBy=top&apiKey=01372794d65d437b88b19d238dab8f89").body
      @news_api_sources << result
    end
    @news_api_sources.each do |api_source|
      # @articles << api_source["articles"]
      api_source["articles"].each do |article|
        article["source"] = api_source["source"]
        @articles << article
      end
    end
    render "index.json.jbuilder"
  end
end
