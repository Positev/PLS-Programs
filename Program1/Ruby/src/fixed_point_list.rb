require './fixed_point_number'

# The fixed point number list manages a list of fixed point numbers by providing add, delete, and summation
#   capabilities.
# Author: Trevor Keegan
# Date: 9/16/2020
class FixedPointList
  attr_accessor :nums, :current_q

  # Initialize Fixed Point Number List by initializing @nums to be empty list and @current_q to be 12
  def initialize
    super
    @nums = []
    @current_q = 12
  end
  # change current q value
  # @param [Integer] new_q_value
  def set_q(new_q_value)
    @current_q = new_q_value
  end

  # Add new FixedPointNumber to list
  # @param [FixedPointNumber] fixed_point_num - new fixed point number to add to list
  def add(fixed_point_num)
    @nums.push(fixed_point_num)
  end

  # Remove first instance of provided FixedPointNumber from list
  # @param [FixedPointNumber] fixed_point_num - fixed point num to find and remove
  def delete(fixed_point_num)
    (0...@nums.size).each do |i|
      if @nums[i] == fixed_point_num
        @nums.delete_at(i)
        return true
      end
    end
    false
  end

  # Return Fixed point number as sum of all other fixed point numbers in list
  def sum
    summed = FixedPointNumber.new(0, @current_q)
    @nums.each { |num|
      summed = summed.plus(num, @current_q)
    }
    summed
  end

  # Serialize this list as string. Each element printed on new line
  def to_s
    return '' if @nums.empty?
    @nums.join("\n")
  end
end


