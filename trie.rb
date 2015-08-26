class Trie

  attr_accessor :head
  def initialize
    @head = {}
  end

  def add(word)
    input = word.chars
    letter = input.shift
   @head[letter] = Node.new(letter, input) 
  end

end

class Node

  attr_accessor :value, :links

  def initialize(value, letters)
    @links = {}
    @value = value

    input = letters 
    unless input.empty?
    letter = input.shift
      @links[letter] = Node.new(letter, input) 
    end

  end
end

