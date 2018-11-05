class Scrambler
  ABC_ = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
          "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

  def encrypt(message, shifts)
    scramble(message, shifts, false)
  end

  def decrypt(message, shifts)
    scramble(message, shifts, true)
  end

  def scramble(message, shifts, backwards)
    message_chars = message.downcase.chars
    scrambled = ""
    until message_chars.empty?
      scrambled += shift(message_chars.slice!(0, 4), shifts, backwards)
    end
    scrambled
  end

  def shift(characters, shifts, backwards)
    characters.each_with_index.map do |char, index|
      next char unless char =~ /[a-z ]/
      next ABC_[(ABC_.index(char) - shifts[index]) % 27] if backwards
      ABC_[(ABC_.index(char) + shifts[index]) % 27]
    end.join
  end
end
