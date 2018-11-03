class Encrypter
  def encrypt(message, shifts)
    message_chars = message.downcase.chars
    encrypted = ""

    until message_chars.empty?
      encrypted += shift(message_chars.slice!(0, 4), shifts)
    end
    encrypted
  end
end
