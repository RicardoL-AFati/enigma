class Enigma
  def initialize(encoder, encrypter, decrypter)
    @encoder = encoder
    @encrypter = encrypter
    @decrypter = decrypter
  end

  def encrypt(message, key = nil, date = nil)
    key = @encoder.get_random_five_digit_number_array.join unless key
    date = @encoder.in_DD_MM_YY(Time.now) unless date
    shifts = @encoder.generate_shifts(key, date).values
    encrypted = @encrypter.encrypt(message, shifts)

    {
      encryption: encrypted,
      key: key,
      date: date
    }
  end
end
