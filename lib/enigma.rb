require './lib/key_encoder'
require './lib/scrambler'
require './lib/date_encoder'

class Enigma
  attr_reader :key_encoder, :date_encoder, :scrambler
  def initialize
    @key_encoder = KeyEncoder.new
    @date_encoder = DateEncoder.new
    @scrambler = Scrambler.new
  end

  def encrypt(message, key = nil, date = nil)
    key = @key_encoder.get_random_five_digit_number_array.join unless key
    date, shifts = get_date_and_shifts(key, date)
    encrypted = @scrambler.encrypt(message, shifts)

    {encryption: encrypted, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = nil)
    date, shifts = get_date_and_shifts(key, date)
    decrypted = @scrambler.decrypt(ciphertext, shifts)

    {decryption: decrypted, key: key, date: date}
  end

  def get_date_and_shifts(key, date)
    date = @date_encoder.in_DD_MM_YY(Time.now) unless date
    shifts = generate_shifts(key, date).values
    return date, shifts
  end

  def generate_shifts(key = nil, date = Time.now)
    key_shifts = @key_encoder.generate_key_shifts(key)
    offset_shifts = @date_encoder.generate_offset_shifts(date)

    form_final_shifts(key_shifts, offset_shifts)
  end

  def form_final_shifts(key_shifts, offset_shifts)
    key_shifts.keys.reduce({}) do |shifts, letter|
      shifts[letter] = key_shifts[letter] + offset_shifts[letter]
      shifts
    end
  end
end
