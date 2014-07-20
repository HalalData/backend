class HomeController < ApplicationController
  def index
  end

  def show
  	@Places = Index.full_text_search(params[:query], params[:page])
  end
end
