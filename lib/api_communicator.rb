require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('https://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # This code below will iterate over the API character giant hash and return the
  # individual one we want
  char_hash = response_hash["results"].find {|char|
    char["name"] == character_name
  }

  movie_collection = char_hash["films"]

  movie_collection_info = movie_collection.map {|https|
    response_string = RestClient.get(https)
    film_hash = JSON.parse(response_string)
    film_hash
    binding.pry
  }
  # ##iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  movie_collection_info
end

get_character_movies_from_api("Luke Skywalker")

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  list = films.map {|movie|
    movie["title"]
  }
  puts list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
