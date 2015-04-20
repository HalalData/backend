# include domain object
require_relative '../../services/venue'

class V1::VenuesController < V1::ApiController
  before_filter :set_services

  def index
    venue_data = @venue.show_recent
    render json: { message: "show recent venues", data: venue_data } 
  end
  
  def create
    @venue.create
    render json: { message: "create new venue" }
  end

  def show
    venue_data = @venue.show_detail(2)
    render json: { message: "show the detail by venue id", data: venue_data }
  end

  def update
    @venue.update
    render json: { message: "venue updated" }
  end

  def delete
    @venue.delete
    render json: { message: "delete the venue" } 
  end

  private
  def set_services
    @venue = ::VenueService.new
  end
end
