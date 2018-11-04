require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @encoder = mock
    @encrypter = mock
    @decrypter = mock
    @enigma = Enigma.new(@encoder, @encrypter, @decrypter)

    @encoder_2 = Encoder.new
    @encrypter_2 = Encrypter.new
    @decrypter_2 = Decrypter.new
    @enigma_2 = Enigma.new(@encoder_2, @encrypter_2, @decrypter_2)
  end

  def test_it_forms_return_hash_from_encryption_given_no_key_or_date
    @encoder.stubs(:get_random_five_digit_number_array).returns(["0", "2", "7", "1", "5"])
    @encoder.stubs(:generate_shifts).returns({A: 2, B: 27, C: 71, D: 15})
    @encrypter.stubs(:encrypt).returns("keder ohulw")
    @encoder.stubs(:in_DD_MM_YY).returns("040895")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_does_not_get_random_five_given_key_and_passes_appropriate_params
    @encoder_2.expects(:get_random_five_digit_number_array).never
    @encoder_2.expects(:generate_shifts).with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    @encrypter_2.expects(:encrypt).with("hello world", [3, 27, 73, 20]).returns("keder ohulw")
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.encrypt("hello world", "02715")
  end

  def test_it_calls_methods_in_sequence_for_decryption_nothing_given
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    encryption = sequence('encryption')
    @encoder_2.expects(:get_random_five_digit_number_array).in_sequence(encryption)
      .returns(["0", "2", "7", "1", "5"])
    @encoder_2.expects(:in_DD_MM_YY).in_sequence(encryption)
      .with(Time.new(1995, 8, 4)).returns("040895")
    @encoder_2.expects(:generate_shifts).in_sequence(encryption)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    @encrypter_2.expects(:encrypt).in_sequence(encryption)
      .with("hello world", [3, 27, 73, 20]).returns("keder ohulw")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.encrypt("hello world")
  end

  def test_it_encrypts_a_message_given_nothing
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    result = @enigma_2.encrypt("hello world")

    assert_equal 11, result[:encryption].length
    refute_equal "hello world", result[:encryption]
    assert_equal 5, result[:key].length
    assert_equal "040895", result[:date]
  end

  def test_it_encrypts_a_message_given_key
    @encoder_2.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.encrypt("hello world", "02715")
  end

  def test_it_encrypts_a_message_given_key_and_date
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.encrypt("hello world", "02715", "040895")
  end

  def test_it_decrypts_a_message_given_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_decrypts_a_message_given_key
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma_2.decrypt("keder ohulw", "02715")
  end

  def test_it_returns_date_and_shifts_given_key
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    @encoder_2.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})

    expected = ["040895", [3, 27, 73, 20]]
    assert_equal expected, @enigma_2.get_date_and_shifts("02715", nil)
  end

  def test_it_returns_date_and_shifts_given_both
    @encoder_2.expects(:in_DD_MM_YY).never
    @encoder_2.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})

    expected = ["040895", [3, 27, 73, 20]]
    assert_equal expected, @enigma_2.get_date_and_shifts("02715", "040895")
  end

  def test_it_returns_final_hash_for_encryption
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.return_hash("02715", "040895", encryption: "keder ohulw")
  end

  def test_it_returns_final_hash_for_decryption
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.return_hash("02715", "040895", decryption: "hello world")
  end
end
