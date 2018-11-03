require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new()
  end

  def test_it_has_an_encoder
    
  end

  def test_it_has_an_encrypter

  end

  def test_it_has_a_decrypter

  end

  def test_it_encrypts_a_message_no_key_or_date_given
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_encrypts_a_message_key_given
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end
end
