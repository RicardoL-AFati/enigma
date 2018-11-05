class Encoder
  def generate_shifts(key = nil, date = Time.now)
    key_shifts = generate_key_shifts(key)
    offset_shifts = generate_offset_shifts(date)

    form_final_shifts(key_shifts, offset_shifts)
  end

  def form_final_shifts(key_shifts, offset_shifts)
    key_shifts.keys.reduce({}) do |shifts, letter|
      shifts[letter] = key_shifts[letter] + offset_shifts[letter]
      shifts
    end
  end

  def empty_shifts
    {A: "", B: "", C: "", D: ""}
  end
end
