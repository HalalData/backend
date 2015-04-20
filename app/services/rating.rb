# This class is intended for describing the business logic.
class RatingService
  
  # User can give rating to the venue via this method.
  # TBD:
  #   Should we define the rating value in integer, eg.,
  #   - 1 when the base ingredients is explicitly known halal (seafood, vegetarian, mentioning no pork, etc)
  #   - 2 when the owner is known a muslim
  #   - 3 when the venue give a halal sign
  #   - 4 when the venue is displaying their halal certificate
  #
  #   or we explicitly show the sentence on user interface then user can give a checklist?
  def give_rating(venue_id, rating)
  end
  
  # Show the rating of the venue.
  def show_rating(venue_id)
  end

end
