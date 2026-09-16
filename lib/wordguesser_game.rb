class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    # 1. Check nil FIRST to avoid NoMethodError on nil
    raise ArgumentError, "NEEDS TO BEA LETTA" if letter.nil? || letter.empty? || letter !~ /[a-zA-Z]/

    # 2. Downcase BEFORE checking repeated guesses so 'A' and 'a' match correctly
    letter = letter.downcase

    # 3. Check for repeated guesses
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    # 4. Record guess
    if @word.downcase.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end

    true
  end

  def word_with_guesses
    displayed = ''
    @word.each_char do |char|
      if @guesses.include?(char.downcase)
        displayed << char
      else
        displayed << '-'
      end
    end
    displayed
  end

  def check_win_or_lose
    return :win if !word_with_guesses.include?('-')
    return :lose if @wrong_guesses.length >= 7

    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end