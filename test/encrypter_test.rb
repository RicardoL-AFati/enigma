require 'test/test_helper'

class EncrypterTest < Mintest::Test
  def setup
    @encrypter = Encrypter.new
  end

  def test_it_encrypts_message
    expected = "keder ohulw"
    result = @encrypter.encrypt("hello world",
      {A: 3, B: 27, C: 73, D: 20})

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_forwards
    expected = ["k", "e", "d", "e"]
    result = @encrypter.shift(["h", "e", "l", "l"],
      [3, 27, 73, 20])

    assert_equal expected, result
  end
end
