class Enigma
  def initialize(encoder, encrypter, decrypter)
    @encoder = encoder
    @encrypter = encrypter
    @decrypter = decrypter
  end

  def encrypt(message, key = nil, date = nil)
    key = @encoder.get_random_five_digit_number_array.join unless key
    
    shifts = @encoder.generate_shifts.values unless key || date


    encrypted = @encrypter.encrypt(message, shifts) unless key || date

  end
end
