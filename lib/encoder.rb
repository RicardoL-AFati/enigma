class Encoder
  def get_random_five_digit_number_array
    random = rand(9999999999999).to_s.chars.shuffle.slice(0, 5)

    (5 - random.length).times { random.unshift("0") } if random.length < 5
    random
  end
end
