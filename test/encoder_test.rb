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

  def test_it_generate_offset_shifts
    @encoder.stubs(:date_in_MM_DD_YY).returns("110318")
    @encoder.stubs(:get_offset_code).returns(["1", "1", "2", "4"])

    expected = {A: 1, B: 1, C: 2, D: 4}
    result = @encoder.generate_offset_shifts(Time.now)

    assert_equal expected, result
  end

  def test_it_gets_offset_code_given_date
    @encoder.stubs(:date_in_MM_DD_YY).returns("110318")

    expected = ["1", "1", "2", "4"]

    assert_equal expected, @encoder.get_offset_code(Time.now)
  end
end
