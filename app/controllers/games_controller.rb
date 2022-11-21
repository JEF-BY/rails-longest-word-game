require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << @alphabet.sample }
    @letters
  end

  def score
    # @valid = false

    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @serialized_dictionary = URI.open(@url).read
    @dictionary = JSON.parse(@serialized_dictionary)

    @regex = "/[#{params[:letters]}]/"

    @result = if @dictionary['found'] == false
                "Sorry but #{params[:word]} does not seem to be a valid English word..."
              elsif @regex.match?(params[:word])
                "Sorry but #{params[:word]} can\'t be built out of #{params[:letters].join(', ')}"
              else
                "Congratulations! #{params[:word]} is a valid English word!"
              end
  end
end
