require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_has_no_key_to_start
    assert_nil @encoder.key
  end

  def test_it_generate_shifts_given_no_key_or_date
    key_shifts = {A: 12, B: 26, C: 60, D: 5}
    offset_shifts = {A: 2, B: 4, C: 5, D: 9}
    @encoder.stubs(:generate_key_shifts).returns(key_shifts)
    @encoder.stubs(:generate_offset_shifts).returns(offset_shifts)

    expected = {A: 14, B: 30, C: 65, D: 14}

    assert_equal expected, @encoder.generate_shifts
  end

  def test_it_generates_key_shifts_given_key
    expected = {A: 12, B: 26, C: 60, D: 5}

    assert_equal expected, @encoder.generate_key_shifts("12605")
  end

  def test_it_generates_a_random_five_digit_number_array
    result = @encoder.get_random_five_digit_number_array

    assert_instance_of Array, result
    assert_equal 5, result.length
    result.each {|number| assert number =~ /[0-9]/}
  end

  def test_it_generate_offset_shifts_for_today
    Time.stubs(:now).returns(Time.new(2018, 11, 3))

    expected = {A: 9, B: 9, C: 2, D: 4}
    result = @encoder.generate_offset_shifts(Time.now)

    assert_equal expected, result
  end

  def test_it_generate_offset_shifts_for_given_time
    expected = {A: 8, B: 9, C: 0, D: 0}
    result = @encoder.generate_offset_shifts(Time.new(1970, 01, 01))

    assert_equal expected, result
  end

  def test_it_gets_offset_code_for_date
    Time.stubs(:now).returns(Time.new(2018, 11, 03))
    @encoder.stubs(:date_in_DD_MM_YY).returns("031118")

    expected = ["9", "9", "2", "4"]

    assert_equal expected, @encoder.get_offset_code(Time.now)
  end

  def test_it_gets_date_in_DD_MM_YY
    Time.stubs(:now).returns(Time.new(2018, 11, 03))
    expected = "031118"

    assert_equal expected, @encoder.in_DD_MM_YY(Time.now)
  end
end
