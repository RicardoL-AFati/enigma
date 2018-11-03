class Encoder
  def get_random_five_digit_number_array
    random = rand(9999999999999).to_s.chars.shuffle.slice(0, 5)

    (5 - random.length).times { random.unshift("0") } if random.length < 5
    random
  end

  def generate_key_shifts
    random_key = get_random_five_digit_number_array
    random_key.each_with_index.reduce(empty_shifts) do |shifts, (digit, index)|
      key_shifts[:A] += digit if index == 0 || index == 1
      key_shifts[:B] += digit if index == 1 || index == 2
      key_shifts[:C] += digit if index == 2 || index == 3
      key_shifts[:D] += digit if index == 3 || index == 4
      key_shifts
    end.transform_values!(&:to_i)
  end

  def generate_offset_shifts(date = Time.now)
    require "pry"; binding.pry
    date_in_MM_DD_YY(date)
    hash = mm_dd_yy.chars.each_with_index.reduce(empty_shifts) do |shifts, (num, index)|
      shifts[empty_shifts.keys[index]] = num.to_i
    end
    require "pry"; binding.pry
  end

  def empty_shifts
    {A: "", B: "", C: "", D: ""}
  end
end
