class Api::V1::KeywordsController < ApplicationController
  def index
    @keywords = Keyword.all
    render "index.json.jbuilder"
  end
end
