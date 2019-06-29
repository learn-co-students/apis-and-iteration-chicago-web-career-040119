#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
show_character_movies(character)

# 
# luke = show_character_movies("Luke Skywalker")
#
# binding.pry
#
# puts "khkh"
