class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(new_word)
  	self.word = new_word
  	self.guesses = ''
  	self.wrong_guesses = ''
  end

  def is_valid?(letter)
  	return letter =~ /^[a-z]$/i
  end

  def guess(letter)
  	unless is_valid? letter
  		raise ArgumentError
  	end
  	letter.downcase!
  	is_changed = false
  	if self.word.include? letter
  		unless self.guesses.include? letter
  			self.guesses += letter
  			is_changed = true
  		end
  	else
  		unless self.wrong_guesses.include? letter
  			self.wrong_guesses += letter
  			is_changed = true
  		end
  	end
  	return is_changed
  end

  def word_with_guesses
  	word_guessed = self.word.dup
  	self.word.split('').uniq.each do |letter|
  		unless self.guesses.include? letter
  			word_guessed.gsub!(letter, '-')
  		end
  	end
  	return word_guessed
  end

  def check_win_or_lose
  	status = :play
  	if self.word == word_with_guesses
  		status = :win
  	end
  	if self.wrong_guesses.length >= 7
  		status = :lose
  	end
  	return status
  end

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end