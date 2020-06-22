require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = Array.new(8) { ('a'..'z').to_a.sample }
    @letters += Array.new(2) { %w(a e i o u).sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @in_grid = in_grid?(@word, @letters)
    @in_dictionary = in_dictionary?(@word)
  end

  private

  def in_grid?(word, letters)
    word.downcase.chars.all? { |letter| word.downcase.count(letter) <= letters.count(letter) }
  end

  def in_dictionary?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
