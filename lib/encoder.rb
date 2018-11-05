class Encoder
  attr_reader :key
  def initialize
    @key = nil
  end

  def generate_shifts(key = nil, date = Time.now)
    key_shifts = generate_key_shifts(key)
    offset_shifts = generate_offset_shifts(date)

    form_final_shifts(key_shifts, offset_shifts)
  end

  def generate_key_shifts(given_key)
    @key = given_key.chars if given_key
    get_random_five_digit_number_array unless @key
    key_shifts = form_key_shifts(key)
    @key = nil
    key_shifts
  end

  def generate_offset_shifts(date)
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
    date = in_DD_MM_YY(date) unless date.class == String
    (date.to_i ** 2).to_s[-4..-1].chars
  end

  def form_final_shifts(key_shifts, offset_shifts)
    key_shifts.keys.reduce({}) do |shifts, letter|
      shifts[letter] = key_shifts[letter] + offset_shifts[letter]
      shifts
    end
  end

  def form_key_shifts(key)
    key.each_with_index.reduce(empty_shifts) do |shifts, (digit, index)|
      next shifts if index == 4
      shifts[shifts.keys[index]] += key[index] + key[index + 1]
      shifts
    end.transform_values!(&:to_i)
  end

  def in_DD_MM_YY(date)
    date.strftime("%d%m%y")
  end

  def empty_shifts
    {A: "", B: "", C: "", D: ""}
  end
end
