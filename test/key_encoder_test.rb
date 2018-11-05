require './test/test_helper'

class KeyEncoderTest < Minitest::Test
  def setup
    @key_encoder = KeyEncoder.new
  end

  def test_it_has_no_key_to_start
    assert_nil @key_encoder.key
  end

  def test_it_generates_key_shifts_given_key
    expected = {A: 12, B: 26, C: 60, D: 5}

    assert_equal expected, @key_encoder.generate_key_shifts("12605")
  end

  def test_it_generates_a_random_five_digit_number_array
    result = @key_encoder.get_random_five_digit_number_array

    assert_instance_of Array, result
    assert_equal 5, result.length
    result.each {|number| assert number =~ /[0-9]/}
  end

  def test_it_forms_key_shifts
    key = ["0", "2", "7", "1", "5"]

    expected = {A: 2, B: 27, C: 71, D: 15}

    assert_equal expected, @key_encoder.form_key_shifts(key)
  end
end
