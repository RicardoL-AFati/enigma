require './lib/scrambler'

class Encrypter < Scrambler
  def encrypt(message, shifts)
    scramble(message, shifts, false)
  end
end
