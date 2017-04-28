class Api::V1::SourcesController < ApplicationController
  def index
    @sources = Source.all
    render "index.json.jbuilder"
  end
end
