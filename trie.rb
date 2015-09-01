class Trie

  attr_accessor :head
  def initialize
    @head = {}
  end

  def add(word)
    input = word.downcase.chars
    letter = input.shift
    if head[letter]
      head[letter].pass(input)
    else
      head[letter] = Node.new(letter, input)
    end
  end

  def verify_word(word)
    input = word.downcase.chars
    if head[input.first]
      head[input.first].verify_word(input)
    else
      false
    end
  end
end

class Node

  attr_accessor :value, :links, :word

  def initialize(value, letters)
    @links = {}
    @value = value
    @word = false

    if letters.empty?
      @word = true
    else
      add_node(letters)
    end
  end

  def is_word?
    word
  end

  def add_node(letters)
    letter = letters.shift
    @links[letter] = Node.new(letter, letters)
  end

  def pass(letters)
    if links.keys.include?(letters.first)
      links[letters[0]].pass(letters[1..-1])
    else
      add_node(letters)
    end
  end

  def verify_word(word_array)
    flag = word
    unless !links.keys.include?(word_array[1]) || word_array.count == 1
      flag = links[word_array[1]].verify_word(word_array[1..-1])
    end
    flag
  end

end
