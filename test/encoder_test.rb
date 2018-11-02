require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_generates_key_shifts_given_random_five_digits
    random = ["1", "2", "6", "0", "5"]
    @encoder.stubs(:get_random_five_digit_number).returns(random)

    expected = {A: 1, B: 2, C: 6, D: 0, E: 5}

    assert_equal expected, @encoder.generate_key_shifts
  end

  def test_it_generates_a_random_five_digit_number
    skip
    result = @encoder.get_random_five_digit_number

    assert_instance_of Array, result
    assert_equal 5, result.length
  end
end
