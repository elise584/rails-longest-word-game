require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = rand(4..10)
    @letters = Array.new(@grid) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, grid)
    grid = grid.split(' ')
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    return json['found']
  end

  def score
    # The word can't be built out of the original grid
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    @result = ''
    if included?(params[:response].upcase, params[:letters])
      if english_word?(params[:response])
        @result = "Congratulations! #{params[:response].upcase} is a valid English word!"
      else
        return @result = "Sorry but #{params[:response].upcase} does not seem to be a valid English word..."
      end
    else
      return @result = "Sorry but #{params[:response].upcase} can't be built out of #{params[:letters].split(' ').join(', ')}"
    end
    @result
  end
end
