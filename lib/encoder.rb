class Encoder
  def get_random_five_digit_number_array
    random = rand(9999999999999).to_s.chars.shuffle.slice(0, 5)

    (5 - random.length).times { random.unshift("0") } if random.length < 5
    random
  end

  def generate_key_shifts
    random_key = get_random_five_digit_number_array
    random_key.each_with_index.reduce(empty_shifts) do |shifts, (digit, index)|
      shifts[:A] += digit if index == 0 || index == 1
      shifts[:B] += digit if index == 1 || index == 2
      shifts[:C] += digit if index == 2 || index == 3
      shifts[:D] += digit if index == 3 || index == 4
      shifts
    end.transform_values!(&:to_i)
  end

  def generate_offset_shifts(date = Time.now)
    code = get_offset_code(date)
    code.each_with_index.reduce(empty_shifts) do |shifts, (num, index)|
      shifts[shifts.keys[index]] = num.to_i
      shifts
    end
  end

  def empty_shifts
    {A: "", B: "", C: "", D: ""}
  end

  def get_offset_code(date)
    date = in_MM_DD_YY(date)
    (date.to_i ** 2).to_s[-4..-1].chars
  end

  def in_MM_DD_YY(date)
    date.strftime("%m%d%y")
  end
end
