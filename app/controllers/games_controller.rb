require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = Array.new(7) { ('A'..'Z').to_a.sample }
    @letters += Array.new(3) { %w(A E I O U Y).sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @in_grid = in_grid?(@word, @letters)
    @in_dictionary = in_dictionary?(@word)
  end

  private

  def in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def in_dictionary?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
