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

    # check from 4sq
    if @Place.city_name
      client = Foursquare2::Client.new(
        client_id: 'ZS2RFX0CSAP3KIV1DYM24OKVZXMGHIJ1SNOAO1ANJOBIQOJ3', 
        client_secret: 'YYYMXUT51CJ02Y2SFCKTRFPVQ1HESWCAVOGVBWQNXUZUR0TS',
        api_version: '20140701'
        )

      @Venue = client.search_venues(ll: @Place.city_latitude.to_s + ',' + @Place.city_longitude.to_s, query: @Place.name)
    end
  end

  def update
  end

  def destroy
  end
end
