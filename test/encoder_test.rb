require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_generates_key_shifts_given_random_five_digits
    random = ["1", "2", "6", "0", "5"]
    @encoder.stubs(:get_random_five_digit_number_array).returns(random)

    expected = {A: 12, B: 26, C: 60, D: 5}

    assert_equal expected, @encoder.generate_key_shifts
  end

  def test_it_generates_a_random_five_digit_number_array
    result = @encoder.get_random_five_digit_number_array

    assert_instance_of Array, result
    assert_equal 5, result.length
    result.each {|number| assert number =~ /[0-9]/}
  end
end
