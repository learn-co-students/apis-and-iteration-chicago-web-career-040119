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

def get_character_movies_from_api(character_name)

  character = find_character_by_name(character_name)
  films_arr = character["films"].map do |film_url|
    url_to_hash(film_url)
  end
  films_arr
end

def print_movies(films)
  films.map do |film|
    film["title"]
  end.each_with_index do |title, index|
    puts "#{index + 1}. #{title}"
  end

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end
