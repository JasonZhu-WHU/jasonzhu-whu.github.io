class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :correct_lst
  attr_accessor :wrong_lst
  attr_accessor :word_with_guesses
  attr_accessor :wrong_count
  attr_accessor :check_win_or_lose

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @correct_lst = ""
    @wrong_lst = ""
    @word_with_guesses = ""
    @wrong_count = 0
    @check_win_or_lose = :play
    for i in 1..word.length
      word_with_guesses.concat('-')
    end
  end

  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  def is_alpha(c)
    if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')
      return true
    else
      return false
    end
  end

  def guess(input)
    if input == nil || !is_alpha(input)
      raise ArgumentError
    elsif input >= "A" && input <= "Z"
      return false
    else
      if word.index(input) != nil
        if @correct_lst.index(input) == nil
          @guesses = input
          @correct_lst.concat(input)
          for i in 0..word.length-1
            if word[i] == input
              @word_with_guesses[i] = input
            end
          end
          if word_with_guesses.index('-') == nil
            @check_win_or_lose = :win
          end
        else
          return false
        end
      else
        if @wrong_lst.index(input) == nil
          @wrong_guesses = input
          @wrong_lst.concat(input)
          @wrong_count = @wrong_count + 1
          if wrong_count >= 7
            @check_win_or_lose = :lose
          end
        else
          return false
        end
      end
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
