class HomeController < ApplicationController
  def index
  end

  def show
  	places = Search.full_text_search(params[:query])

  	#@response = places
  end
end
