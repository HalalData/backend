class HomeController < ApplicationController
  def index
  end

  def show
  	@Places = Search.full_text_search(params[:query], params[:page])
  end
end
