require './FixedPointNumber'
class FixedPointList
  attr_accessor :nums, :current_q

  def initialize
    super
    @nums = []
    @current_q = 12
  end
  def set_q(new_q_value)
    @current_q = new_q_value
  end


  def add(fixed_point_num)
    @nums.push(fixed_point_num)
  end

  def delete(fixed_point_num)
    @nums.each { |num|
      if num == fixed_point_num
        @nums.delete(num)
        return true
      end
    }
    return false
  end

  def sum_all
    summed = FixedPointNumber.new(0,@current_q)
    @nums.each { |num|
      summed = summed.plus(num, @current_q)
    }
    return summed
  end

  def to_s
    if @nums.empty?
      return ""
    end

    out = @nums.join("\n")
    return out
  end
end


