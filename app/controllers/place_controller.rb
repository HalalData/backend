class PlaceController < ApplicationController
  def index
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @Place = Index.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
