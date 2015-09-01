require "minitest/autorun"
require "minitest/pride"
require_relative "trie"


class TrieTest < Minitest::Test

  def test_can_initialize_a_trie
    trie = Trie.new

    assert_kind_of Trie, trie
    assert_equal Hash, trie.head.class
  end

  def test_can_add_one_letter_to_trie
    trie = Trie.new
    trie.add("a")

    assert trie.head.keys.include?("a")
    assert_kind_of Node, trie.head["a"]
  end

  def test_can_add_a_word_to_a_trie
    trie = Trie.new
    trie.add("cat")

    assert_equal "c", trie.head["c"].value
    assert trie.head["c"].links.keys.include?("a")
    assert trie.head["c"].links["a"].links.keys.include?("t")
  end

  def test_can_add_two_word_to_a_trie
    trie = Trie.new
    trie.add("hi")
    trie.add("ho")

    assert_equal 1, trie.head.keys.count
    assert_equal ["i", "o"], trie.head["h"].links.keys
  end

  def test_can_add_multiple_complex_words
    trie = Trie.new
    trie.add("hello")
    trie.add("help")
    trie.add("hero")
    trie.add("halleluja")
    trie.add("heroku")

    assert_equal 1, trie.head.keys.count
    assert_equal ["e", "a"], trie.head["h"].links.keys
    assert_equal ["l", "r"], trie.head["h"].links["e"].links.keys
  end

  def test_case_insensitive
    trie = Trie.new
    trie.add("heroku")
    trie.add("Heroku")

    assert_equal ["h"], trie.head.keys
  end

  def test_can_set_as_word
    trie = Trie.new
    trie.add("he")
    trie.add("hello")

    assert trie.verify_word("he")
    refute trie.verify_word("hel")
    assert trie.verify_word("hello")
  end

end

class NodeTest < Minitest::Test

  def test_can_initialize_a_node
    node = Node.new("h", ["l"])

    assert_equal "h", node.value
    assert_equal Hash, node.links.class
  end

  def test_can_add_a_node
    node = Node.new("h", ["e"])
    node.add_node(["i"])

    assert_equal ["e", "i"], node.links.keys
  end

  def test_can_pass_letters_to_node
    node = Node.new("h", ["e", "y"])
    node.pass(["e", "l", "l", "o"])

    assert_equal ["e"], node.links.keys
    assert_equal ["y", "l"], node.links["e"].links.keys
  end

  def test_it_sets_as_word
    node = Node.new("h", ["e", "l", "l", "o"])

    refute node.is_word?
    assert node.verify_word(["h", "e", "l", "l", "o"])
  end

end
