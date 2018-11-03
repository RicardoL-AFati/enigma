class Encoder
  attr_reader :key
  def initialize
    @key = nil
  end

  def generate_shifts
    key_shifts = generate_key_shifts
    offset_shifts = generate_offset_shifts

    key_shifts.keys.reduce({}) do |shifts, letter|
      shifts[letter] = key_shifts[letter] + offset_shifts[letter]
      shifts
    end
  end

  def generate_key_shifts
    get_random_five_digit_number_array unless @key
    key_shifts = key.each_with_index.reduce(empty_shifts) do |shifts, (digit, index)|
      shifts[:A] += digit if index == 0 || index == 1
      shifts[:B] += digit if index == 1 || index == 2
      shifts[:C] += digit if index == 2 || index == 3
      shifts[:D] += digit if index == 3 || index == 4
      shifts
    end.transform_values!(&:to_i)
    @key = nil
    key_shifts
  end

  def generate_offset_shifts(date = Time.now)
    code = get_offset_code(date)
    code.each_with_index.reduce(empty_shifts) do |shifts, (num, index)|
      shifts[shifts.keys[index]] = num.to_i
      shifts
    end
  end

  def get_random_five_digit_number_array
    random = rand(9999999999999).to_s.chars.shuffle.slice(0, 5)

    (5 - random.length).times { random.unshift("0") } if random.length < 5
    @key = random
  end

  def get_offset_code(date)
    date = in_DD_MM_YY(date)
    (date.to_i ** 2).to_s[-4..-1].chars
  end

  def in_DD_MM_YY(date)
    date.strftime("%d%m%y")
  end

  def empty_shifts
    {A: "", B: "", C: "", D: ""}
  end
end
