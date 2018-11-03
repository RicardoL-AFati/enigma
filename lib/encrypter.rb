class Encrypter
  ABC_ = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
          "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

  def encrypt(message, shifts)
    message_chars = message.chars
    encrypted = []

    until message_chars.empty?
      encrypted << shift(message_chars.slice!(0, 4), shifts.values)
    end
    encrypted.flatten.join
  end

  def shift(characters, shifts)
    characters.each_with_index.map do |char, index|
      original_index = ABC_.index(char)
      ABC_[(original_index + shifts[index]) % 27]
    end.join
  end
end
