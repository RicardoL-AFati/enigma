require './test/test_helper'

class ScramblerTest < Minitest::Test
  def setup
    @scrambler = Scrambler.new
  end

  def test_it_shifts_an_array_of_character_forwards
    expected = "kede"
    result = @scrambler.shift(["h", "e", "l", "l"],
      [3, 27, 73, 20])

    assert_equal expected, result
  end

  def test_it_shifts_an_array_of_character_backwards
    expected = "hell"
    result = @scrambler.shift(["k", "e", "d", "e"],
      [3, 27, 73, 20])

    assert_equal expected, result
  end
end
