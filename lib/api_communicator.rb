require 'rest-client'
require 'json'
require 'pry'

#helper method to make the web request
def get_api_json
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(response_string)
end

#helper method to find and return character data
def find_char_data(character_name, response_hash)
  titleized_character_name = character_name.split.map { |word| word.capitalize }.join(' ')
  response_hash["results"].find {|char_data| char_data["name"] == titleized_character_name}
end

#helper method to iterate through data and return movie names matching search
def get_movies_data(character_data)
  if character_data
    character_films = character_data["films"]
    movie_response_string = character_films.map {|film_url| RestClient.get(film_url)}
    movie_response_string.map {|response_string| JSON.parse(response_string)}
  else
    nil
  end
end

def get_character_movies_from_api(character_name)
  get_movies_data(find_char_data(character_name, get_api_json()))
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films ? films.map {|film| film["title"]} : ["Sorry, no movies were found for that character.  Please try again."]
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  puts print_movies(films)
end
