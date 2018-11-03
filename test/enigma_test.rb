require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @encoder = mock
    @encrypter = mock
    @decrypter = mock
    @enigma = Enigma.new(@encoder, @encrypter, @decrypter)
  end

  def test_it_forms_return_hash_from_encryption_given_no_key_or_date
    @encoder.stubs(:get_random_five_digit_number_array)
      .returns(["0", "2", "7", "1", "5"])
    @encoder.stubs(:generate_shifts)
      .returns({A: 2, B: 27, C: 71, D: 15})
    @encrypter.stubs(:encrypt).returns("keder ohulw")
    @encoder.stubs(:in_DD_MM_YY).returns("040895")
    
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_encrypts_a_message_key_given
    skip
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end
end
