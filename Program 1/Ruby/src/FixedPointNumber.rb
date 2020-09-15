class FixedPointNumber
  attr_reader :int_val, :q_val

  def initialize(val, q)
    super()
    @q_val = q
    if val.is_a?(Integer)
      @int_val = val
    elsif val.is_a?()
    @int_val = val * 2 ** q_val
    end

  end

  def to_double
    return int_val / 2 ** q_val
  end

  def to_q_val(q)
    q_diff = q - @q_val
    if(q_diff > 0)
      new_int_val = @int_val << q_diff.abs()
    else
      new_int_val = @int_val >> q_diff.abs()
    end

    return FixedPointNumber(new_int_val, q_diff)
  end


  def to_s
    formatted_double = "%.6f" % self.to_double
    return "#{@int_val}, #{@q_val}: #{formatted_double}"
  end

  def ==(other_number)
    return @int_val == other_number.intVal and @q_val == other_number.q_val
  end

  def sum(other_number, q_val)
    converted_this = to_q_val(q_val)
    converted_other = other_number.to_q_val(q_val)
    return FixedPointNumber(converted_other.int_val + converted_this.int_val, q_val)
  end

end
