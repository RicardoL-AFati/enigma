require './test/test_helper'

class DecrypterTest < Minitest::Test
  def setup
    @decrypter = Decrypter.new
  end

  def test_it_encrypts_message
    expected = "hello world"
    result = @decrypter.decrypt("keder ohulw",
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_characters
    expected = "kede"
    result = @decrypter.shift(["h", "e", "l", "l"],
      [3, 27, 73, 20], true)

    assert_equal expected, result
  end
end
