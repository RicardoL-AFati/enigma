require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_forms_return_hash_from_encryption_given_no_key_or_date
    @enigma.encoder.stubs(:get_random_five_digit_number_array).returns(["0", "2", "7", "1", "5"])
    @enigma.encoder.stubs(:generate_shifts).returns({A: 2, B: 27, C: 71, D: 15})
    @enigma.encrypter.stubs(:encrypt).returns("keder ohulw")
    @enigma.encoder.stubs(:in_DD_MM_YY).returns("040895")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_does_not_get_random_five_given_key_and_passes_appropriate_params
    @enigma.encoder.expects(:get_random_five_digit_number_array).never
    @enigma.encoder.expects(:generate_shifts).with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    @enigma.encrypter.expects(:encrypt).with("hello world", [3, 27, 73, 20]).returns("keder ohulw")
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_calls_methods_in_sequence_for_decryption_nothing_given
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    encryption = sequence('encryption')
    @enigma.encoder.expects(:get_random_five_digit_number_array).in_sequence(encryption)
      .returns(["0", "2", "7", "1", "5"])
    @enigma.encoder.expects(:in_DD_MM_YY).in_sequence(encryption)
      .with(Time.new(1995, 8, 4)).returns("040895")
    @enigma.encoder.expects(:generate_shifts).in_sequence(encryption)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    @enigma.encrypter.expects(:encrypt).in_sequence(encryption)
      .with("hello world", [3, 27, 73, 20]).returns("keder ohulw")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_encrypts_a_message_given_nothing
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    result = @enigma.encrypt("hello world")

    assert_equal 11, result[:encryption].length
    refute_equal "hello world", result[:encryption]
    assert_equal 5, result[:key].length
    assert_equal "040895", result[:date]
  end

  def test_it_encrypts_a_message_given_key
    @enigma.encoder.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_encrypts_a_message_given_key_and_date
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_decrypts_a_message_given_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_decrypts_a_message_given_key
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715")
  end

  def test_it_returns_date_and_shifts_given_key
    Time.stubs(:now).returns(Time.new(1995, 8, 4))

    @enigma.encoder.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})

    expected = ["040895", [3, 27, 73, 20]]
    assert_equal expected, @enigma.get_date_and_shifts("02715", nil)
  end

  def test_it_returns_date_and_shifts_given_both
    @enigma.encoder.expects(:in_DD_MM_YY).never
    @enigma.encoder.expects(:generate_shifts)
      .with("02715", "040895").returns({A: 3, B: 27, C: 73, D: 20})

    expected = ["040895", [3, 27, 73, 20]]
    assert_equal expected, @enigma.get_date_and_shifts("02715", "040895")
  end
end
