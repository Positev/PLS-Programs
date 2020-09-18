# frozen_string_literal: true

# The fixed point number, as opposed to floating point number takes advantage of mathematics to represent a decimal
#   number on hardware that might not support floating point numbers.
# Author: Trevor Keegan
# Date: 9/16/2020
class FixedPointNumber
  attr_reader :int_val, :q_val

  # Initialize Fixed point number with double value to be converted or
  # Params:
  # @param [Numeric] val - value to create FixedPointNumber as. if val is type Integer, int_val is set directly to val.
  #                         Otherwise val is set to (val * 2.0**q_val).to_i
  # @param [Integer] q - q value to use for this fixed point number

  def initialize(val, q)
    super()
    @q_val = q
    @int_val = if val.is_a?(Integer)
                 val
               else
                 (val * 2.0**q_val).to_i
               end

  end

  # Convert this fixed point number to a double number
  def to_double
    (int_val.to_f / 2.0**q_val).to_f
  end

  # Convert this fixed point number to use fixed point number with q value
  # Params:
  # @param [Integer] q value to use for this fixed point number
  def to_q_val(q)
    q_diff = q - @q_val
    new_int_val = if q_diff > 0
                    @int_val << q_diff.abs
                  else
                    @int_val >> q_diff.abs
                  end

    FixedPointNumber.new(new_int_val, q_diff)
  end

  # Serialize this FixedPointNumber to string such that int val, q val and equivalent double are represented
  def to_s
    formatted_double = '%.6f' % to_double
    "#{@int_val}, #{@q_val}: #{formatted_double}"
  end

  # Initialize Fixed point number with double value to be converted or
  # @param [FixedPointNumber] other
  def ==(other)
    @int_val == other.int_val && @q_val == other.q_val
  end

  # Initialize Fixed point number with double value to be converted or
  # @param [FixedPointNumber] other_number - number to sum with this number
  # @param [Integer] q_val - resultant q value desired
  def plus(other_number, q_val)
    converted_this = to_q_val(q_val)
    converted_other = other_number.to_q_val(q_val)
    FixedPointNumber.new(converted_other.int_val + converted_this.int_val, q_val)
  end

end
