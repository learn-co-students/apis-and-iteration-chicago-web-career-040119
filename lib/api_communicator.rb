require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_data = response_hash["results"].find do |item|
    item["name"] == character_name
  end


  film_urls = character_data["films"]
  film_data = film_urls.map do |data_url|
    JSON.parse(RestClient.get(data_url))
  end
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
  # some iteration magic and puts out the movies in a nice list
  films.each_with_index do |data, index|
    puts "#{index + 1}." + data["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

# 
# pry(main)> response_hash
# => {"count"=>87,
#  "next"=>"https://www.swapi.co/api/people/?page=2",
#  "previous"=>nil,
#  "results"=>
#   [{"name"=>"Luke Skywalker",
#     "height"=>"172",
#     "mass"=>"77",
#     "hair_color"=>"blond",
#     "skin_color"=>"fair",
#     "eye_color"=>"blue",
#     "birth_year"=>"19BBY",
#     "gender"=>"male",
#     "homeworld"=>"https://www.swapi.co/api/planets/1/",
#     "films"=>
#      ["https://www.swapi.co/api/films/2/",
#       "https://www.swapi.co/api/films/6/",
#       "https://www.swapi.co/api/films/3/",
#       "https://www.swapi.co/api/films/1/",
#       "https://www.swapi.co/api/films/7/"],
#     "species"=>["https://www.swapi.co/api/species/1/"],
#     "vehicles"=>
#      ["https://www.swapi.co/api/vehicles/14/", "https://www.swapi.co/api/vehicles/30/"],
#     "starships"=>
#      ["https://www.swapi.co/api/starships/12/", "https://www.swapi.co/api/starships/22/"],
#     "created"=>"2014-12-09T13:50:51.644000Z",
#     "edited"=>"2014-12-20T21:17:56.891000Z",
#     "url"=>"https://www.swapi.co/api/people/1/"},
#    {"name"=>"C-3PO",
#     "height"=>"167",
#     "mass"=>"75",
#     "hair_color"=>"n/a",
#     "skin_color"=>"gold",
#     "eye_color"=>"yellow",
#     "birth_year"=>"112BBY",
#     "gender"=>"n/a",
#     "homeworld"=>"https://www.swapi.co/api/planets/1/",
#     "films"=>
#      ["https://www.swapi.co/api/films/2/",
#       "https://www.swapi.co/api/films/5/",
#       "https://www.swapi.co/api/films/4/",
#       "https://www.swapi.co/api/films/6/",
#       "https://www.swapi.co/api/films/3/",
#       "https://www.swapi.co/api/films/1/"],
#     "species"=>["https://www.swapi.co/api/species/2/"],
#     "vehicles"=>[],
#     "starships"=>[],
#     "created"=>"2014-12-10T15:10:51.357000Z",
#
# [1] pry(main)> character_data
# => {"name"=>"Luke Skywalker",
#  "height"=>"172",
#  "mass"=>"77",
#  "hair_color"=>"blond",
#  "skin_color"=>"fair",
#  "eye_color"=>"blue",
#  "birth_year"=>"19BBY",
#  "gender"=>"male",
#  "homeworld"=>"https://www.swapi.co/api/planets/1/",
#  "films"=>
#   ["https://www.swapi.co/api/films/2/",
#    "https://www.swapi.co/api/films/6/",
#    "https://www.swapi.co/api/films/3/",
#    "https://www.swapi.co/api/films/1/",
#    "https://www.swapi.co/api/films/7/"],
#  "species"=>["https://www.swapi.co/api/species/1/"],
#  "vehicles"=>
#   ["https://www.swapi.co/api/vehicles/14/", "https://www.swapi.co/api/vehicles/30/"],
#  "starships"=>
#   ["https://www.swapi.co/api/starships/12/", "https://www.swapi.co/api/starships/22/"],
#  "created"=>"2014-12-09T13:50:51.644000Z",
#  "edited"=>"2014-12-20T21:17:56.891000Z",
#  "url"=>"https://www.swapi.co/api/people/1/"}
#
# pry(main)> film_data
# => [{"title"=>"The Empire Strikes Back",
#   "episode_id"=>5,
#   "opening_crawl"=>
#    "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space....",
#   "director"=>"Irvin Kershner",
#   "producer"=>"Gary Kurtz, Rick McCallum",
#   "release_date"=>"1980-05-17",
#   "characters"=>
#    ["https://www.swapi.co/api/people/1/",
#     "https://www.swapi.co/api/people/2/",
#     "https://www.swapi.co/api/people/3/",
#     "https://www.swapi.co/api/people/4/",
#     "https://www.swapi.co/api/people/5/",
#     "https://www.swapi.co/api/people/10/",
#     "https://www.swapi.co/api/people/13/",
#     "https://www.swapi.co/api/people/14/",
#     "https://www.swapi.co/api/people/18/",
#     "https://www.swapi.co/api/people/20/",
#     "https://www.swapi.co/api/people/21/",
#     "https://www.swapi.co/api/people/22/",
#     "https://www.swapi.co/api/people/23/",
#     "https://www.swapi.co/api/people/24/",
#     "https://www.swapi.co/api/people/25/",
#     "https://www.swapi.co/api/people/26/"],
#   "planets"=>
#    ["https://www.swapi.co/api/planets/4/",
#     "https://www.swapi.co/api/planets/5/",
#     "https://www.swapi.co/api/planets/6/",
#     "https://www.swapi.co/api/planets/27/"],
#   "starships"=>
#    ["https://www.swapi.co/api/starships/15/",
#     "https://www.swapi.co/api/starships/10/",
#     "https://www.swapi.co/api/starships/11/",
#     "https://www.swapi.co/api/starships/12/",
#     "https://www.swapi.co/api/starships/21/",
#     "https://www.swapi.co/api/starships/22/",
#     "https://www.swapi.co/api/starships/23/",
#     "https://www.swapi.co/api/starships/3/",
#     "https://www.swapi.co/api/starships/17/"],
#   "vehicles"=>
#    ["https://www.swapi.co/api/vehicles/8/",
#     "https://www.swapi.co/api/vehicles/14/",
# ...skipping...
#

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
