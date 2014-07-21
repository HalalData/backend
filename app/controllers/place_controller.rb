class PlaceController < ApplicationController
  
  def show
    @Place = Index.find(params[:id])
  end

  <<-DOC
  This function will handle the map display function
  @params city_name is the name of the city
  @return response is a geojson object
  DOC
  def display_map
    city = City.find_by_name params[:city]
    
    # instantiate 4sq
    client = Foursquare2::Client.new(
      client_id: 'ZS2RFX0CSAP3KIV1DYM24OKVZXMGHIJ1SNOAO1ANJOBIQOJ3', 
      client_secret: 'YYYMXUT51CJ02Y2SFCKTRFPVQ1HESWCAVOGVBWQNXUZUR0TS',
      api_version: '20140701'
      )

    result = client.search_venues(ll: city.latitude.to_s + ',' + city.longitude.to_s, query: params[:place])

    respond = {city_name: city.name, city_lat: city.latitude, city_lng: city.longitude, venues: {type: "MultiPoint", coordinates: []}}

    if result
      result.venues.each do |venue|
        if venue.name == params[:place]
          respond[:venues][:coordinates] << [venue.location.lng, venue.location.lat]
        end
      end
    end

    respond_to do |format|
      format.json { render json: respond}
    end
  end
end
