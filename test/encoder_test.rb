require './test/test_helper'

class EncoderTest < Minitest::Test
  def setup
    @encoder = Encoder.new
  end

  def test_it_returns_empty_shifts
    expected = {A: "", B: "", C: "", D: ""}

    assert_equal expected, @encoder.empty_shifts
  end
end
