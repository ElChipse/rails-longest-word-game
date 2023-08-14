require "json"
require "open-uri"

class GamesController < ApplicationController
  def home
  end

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    if !english_word
      return @result = "Sorry but #{params[:new]} is not an english word"
    elsif !grid
      return @result = "Sorry but #{params[:new]} can't built out of #{params[:grid]}"
    else
      return @result = "Congratulations #{params[:new]} is validate"
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:new]}"
    words_serialized = URI.open(url).read
    words = JSON.parse(words_serialized)
    words['found']
  end

  def grid
    params[:new].upcase.chars.sort.all? { |letter| params[:grid].include?(letter) }
  end
end
