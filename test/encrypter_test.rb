require './test/test_helper'

class EncrypterTest < Minitest::Test
  def setup
    @encrypter = Encrypter.new
  end

  def test_it_encrypts_message
    expected = "keder ohulw"
    result = @encrypter.encrypt("hello world",
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_forwards
    expected = "kede"
    result = @encrypter.shift(["h", "e", "l", "l"],
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_returning_special_characters
    expected = "&}x!"
    result = @encrypter.shift(["&", "}", "e", "!"],
      [3, 27, 73, 20])

    assert_equal expected, result
  end
end
