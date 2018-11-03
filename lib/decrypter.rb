require './lib/scrambler'

class Decrypter < Scrambler
  def decrypt(message, shifts)
    scramble(message, shifts, true)
  end
end
