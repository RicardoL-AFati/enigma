require './test/test_helper'

class DateEncoderTest < Minitest::Test
  def setup
    @date_encoder = DateEncoder.new
  end

  def test_it_generate_offset_shifts_for_today
    Time.stubs(:now).returns(Time.new(2018, 11, 3))

    expected = {A: 9, B: 9, C: 2, D: 4}
    result = @date_encoder.generate_offset_shifts(Time.now)

    assert_equal expected, result
  end

  def test_it_generate_offset_shifts_for_given_time
    expected = {A: 8, B: 9, C: 0, D: 0}
    result = @date_encoder.generate_offset_shifts(Time.new(1970, 01, 01))

    assert_equal expected, result
  end

  def test_it_gets_offset_code_for_date
    Time.stubs(:now).returns(Time.new(2018, 11, 03))
    @date_encoder.stubs(:date_in_DD_MM_YY).returns("031118")

    expected = ["9", "9", "2", "4"]

    assert_equal expected, @date_encoder.get_offset_code(Time.now)
  end

  def test_it_gets_date_in_DD_MM_YY
    Time.stubs(:now).returns(Time.new(2018, 11, 03))
    expected = "031118"

    assert_equal expected, @date_encoder.in_DD_MM_YY(Time.now)
  end

  def test_it_forms_offset_shifts
    offset_code = ["5", "2", "2", "5"]

    expected = {A: 5, B: 2, C: 2, D: 5}

    assert_equal expected, @date_encoder.form_offset_shifts(offset_code)
  end
end
