class Scrambler
  ABC_ = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
          "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

  def shift(characters, shifts, backwards = false)
    characters.each_with_index.map do |char, index|
      next char unless char =~ /[a-z ]/
      original_index = ABC_.index(char)
      next ABC_[(original_index - shifts[index]) % 27] if backwards
      ABC_[(original_index + shifts[index]) % 27]
    end.join
  end
end
