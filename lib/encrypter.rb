class Encrypter
  ABC_ = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
          "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

  def encrypt(message, shifts)
    message_chars = message.chars
    encrypted = []

    until message_chars.empty?
      encrypted << shift(message_chars.slice!(0, 4))
    end
    encrypted
  end
end
