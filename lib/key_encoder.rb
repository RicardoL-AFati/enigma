require './lib/encoder'

class KeyEncoder < Encoder
  attr_reader :key
  def initialize
    @key = nil
  end

  def generate_key_shifts(given_key)
    @key = given_key.chars if given_key
    get_random_five_digit_number_array unless @key
    key_shifts = form_key_shifts(key)
    @key = nil
    key_shifts
  end

  def form_key_shifts(key)
    key.each_with_index.reduce(empty_shifts) do |shifts, (num, index)|
      next shifts if index == 4
      shifts[shifts.keys[index]] += key[index] + key[index + 1]
      shifts
    end.transform_values!(&:to_i)
  end

  def get_random_five_digit_number_array
    random = rand(9999999999999).to_s.chars.shuffle.slice(0, 5)

    (5 - random.length).times { random.unshift("0") } if random.length < 5
    @key = random
  end
end
