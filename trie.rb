class Trie

  attr_accessor :head
  def initialize
    @head = {}
  end

  def add(word)
    input = word.downcase.chars
    letter = input.shift
    if head[letter]
      @head[letter].pass(input)
    else
      @head[letter] = Node.new(letter, input)
    end
  end

end

class Node

  attr_accessor :value, :links

  def initialize(value, letters)
    @links = {}
    @value = value

    unless letters.empty?
      add_node(letters)
    end
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
end
