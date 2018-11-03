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
end
