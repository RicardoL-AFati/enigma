require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_generates_a_random_five_digit_number
    result = @encoder.get_random_five_digit_number

    assert_instance_of Array, result
    assert_equal 5, result.length
  end
end
