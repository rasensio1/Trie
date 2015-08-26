require 'minitest/autorun'
require 'minitest/pride'
require_relative 'trie'


class TrieTest < Minitest::Test

  def test_can_initialize_a_trie
    trie = Trie.new
    
    assert_kind_of Trie, trie
    assert_equal Hash, trie.head.class
  end

  def test_can_add_one_letter_to_trie
    trie = Trie.new
    trie.add("a")

    assert trie.head.keys.include?('a')
    assert_kind_of Node, trie.head['a']
  end

  def test_can_add_a_word_to_a_trie
    trie = Trie.new
    trie.add('cat')

    assert_equal 'c', trie.head['c'].value
    assert trie.head['c'].links.keys.include?('a')
    assert trie.head['c'].links['a'].links.keys.include?('t')
  end

end

class NodeTest < Minitest::Test

  def test_can_initialize_a_node
    node = Node.new("h", ['l'])

    assert_equal 'h', node.value
    assert_equal Hash, node.links.class
  end

end
