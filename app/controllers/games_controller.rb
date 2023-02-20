require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
    @letters_blank = @letters.join(" ")
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    result = JSON.parse(response)
    return result["found"]
  end

  def score
    @answer = params[:word]
    @answer_array = @answer.chars

    @grid = params[:letters]
    @grid_array = @grid.split(" ")

    @word_included = @answer_array.all? { |letter| @grid_array.include?(letter) } # true or false
    @english_word = english_word(@answer) # true or false
  end
end
