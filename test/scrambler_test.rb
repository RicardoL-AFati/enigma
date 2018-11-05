require './test/test_helper'

class ScramblerTest < Minitest::Test
  def setup
    @scrambler = Scrambler.new
  end

  def test_it_scrambles_a_message_forwards_or_backwards
    expected = "keder ohulw"
    result = @scrambler.scramble("hello world",
      [3, 27, 73, 20], false)

    assert_equal expected, result

    expected = "hello world"
    result = @scrambler.scramble("keder ohulw",
      [3, 27, 73, 20], true)

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_forwards
    expected = "kede"
    result = @scrambler.shift(["h", "e", "l", "l"],
      [3, 27, 73, 20], false)

    assert_equal expected, result
  end

  def test_it_encrypts_message
    expected = "keder ohulw"
    result = @encrypter.encrypt("hello world",
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_backwards
    expected = "hell"
    result = @scrambler.shift(["k", "e", "d", "e"],
      [3, 27, 73, 20], true)

    assert_equal expected, result
  end

  def test_it_decrypts_message
    expected = "hello world"
    result = @decrypter.decrypt("keder ohulw",
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_returning_special_characters
    expected = "&}x!"
    result = @scrambler.shift(["&", "}", "e", "!"],
      [3, 27, 73, 20], false)

    assert_equal expected, result
  end
end
