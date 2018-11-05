require './lib/encoder'

class DateEncoder < Encoder
  def generate_offset_shifts(date)
    form_offset_shifts(get_offset_code(date))
  end

  def get_offset_code(date)
    date = in_DD_MM_YY(date) unless date.class == String
    (date.to_i ** 2).to_s[-4..-1].chars
  end

  def form_offset_shifts(offset_code)
    offset_code.each_with_index.reduce(empty_shifts) do |shifts, (num, index)|
      shifts[shifts.keys[index]] = num.to_i
      shifts
    end
  end

  def in_DD_MM_YY(date)
    date.strftime("%d%m%y")
  end
end
