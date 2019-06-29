require 'rest-client'
require 'json'
require 'pry'

def url_to_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def find_character_by_name(name)
  response_hash = url_to_hash('http://www.swapi.co/api/people/')

  character = response_hash["results"].find do |character|
    character["name"].downcase == name
  end
end

# def character_url_array(character_name)
#   character = find_character_by_name(character_name)
#   character["films"]
# end

def get_character_movies_from_api(character_name)

  character = find_character_by_name(character_name)
  films_arr = character["films"].map do |film_url|
    url_to_hash(film_url)
  end
  films_arr

  # print_movies(films_arr)

  #make the web request
  # require 'rest-client'

   # RestClient.get('http://example.com/some-website/info')
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)



  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  films.map do |film|
    film["title"]# some iteration magic and puts out the movies in a nice list
  end.each_with_index do |title, index|
    puts "#{index + 1}. #{title}"
  end

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
