# This class is intended for describing the business logic of Venue.
# 
# I'm trying to separate the business logic in domains to avoid getting fat controller.
# I also want to do isolated test for this class. 
class VenueService
  
  # Show recent venues to user.
  # TBD: Is it better if we give default max limit for the result?
  def show_recent(limit = 100)
    # call the model here
  end
  
  # Show detail venue by its id.
  def show_detail(id)
    # call the model here
  end
  
  # Create new venue
  def create
    # call the model here
  end

  # Updating the properties of venue.
  def update
    # call the model here
  end
   
  # Deleting the venue by its id.
  # TBD: 
  #   Will we soft delete or hard delete the data?
  #   Soft means make the data inactive but still keep the data inside the database
  def delete(id)
    # call the model here
  end

end
