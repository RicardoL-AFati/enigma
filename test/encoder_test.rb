require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_generate_shifts_given_no_key_or_date
    key_shifts = {A: 12, B: 26, C: 60, D: 5}
    offset_shifts = {A: 2, B: 4, C: 5, D: 9}
    @encoder.stubs(:generate_key_shifts).returns(key_shifts)
    @encoder.stubs(:generate_offset_shifts).returns(offset_shifts)

    expected = {A: 14, B: 30, C: 65, D: 14}

    assert_equal expected, @encoder.generate_shifts
  end

  def test_it_forms_final_shifts
    key_shifts = {A: 18, B: 99, C: 10, D: 23}
    offset_shifts = {A: 8, B: 9, C: 0, D: 0}

    expected = {A: 26, B: 108, C: 10, D: 23}

    assert_equal expected, @encoder.form_final_shifts(key_shifts, offset_shifts)
  end

  def test_it_returns_empty_shifts
    expected = {A: "", B: "", C: "", D: ""}

    assert_equal expected, @encoder.empty_shifts
  end
end
