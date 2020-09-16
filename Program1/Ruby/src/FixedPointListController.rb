# frozen_string_literal: true

require './FixedPointList'

class FixedPointListController
  attr_accessor :num_list

  def initialize
    super
    @num_list = FixedPointList.new
  end

  def run
    continue = true
    while continue

      command = gets
      response = execute(command)
      puts response
      continue = response != 'Normal termination of program1.'

    end
  end

  def execute(command)
    has_arg = command.match(/\s/)

    if has_arg
      split_command = command.split(' ')
      command = split_command[0]
      response = handle_command(command, split_command[1])
    else
      response = handle_command(command)
    end

    response
  end

  def handle_command(command, arg = nil)
    command_lower = command.downcase
    if command_lower == 'a'
      handle_add(arg)
    elsif command_lower == 'q'
      handle_q_change(arg)
    elsif command_lower == 'd'
      handle_delete(arg)
    elsif command_lower == 'p'
      entries = @num_list.to_s.to_s
      return "All fixed-point numbers in the list are:\n#{entries}" if entries != ''

      'All fixed-point numbers in the list are:'
    elsif command_lower == 's'
      "The sum is #{@num_list.sum}."
    elsif command_lower == 'x'
      'Normal termination of program1.'
    else
      "#{command} is not a valid command!"
    end
  end

  def handle_add(arg)
    if !arg.nil?
      new_fixed_point = FixedPointNumber.new(arg.to_f, @num_list.current_q)
      @num_list.add(new_fixed_point)
      "#{new_fixed_point} was added to the list."
    else
      'Arg missing. You must specify the number to append to the list'
    end
  end

  def handle_q_change(arg)
    if !arg.nil?
      @num_list.current_q = arg.to_i
      "Current q_value was changed to #{@num_list.current_q}."
    else
      'Arg missing. You must specify the new q value'
    end
  end

  def handle_delete(arg)
    if !arg.nil?
      new_fixed_point = FixedPointNumber.new(arg.to_f, @num_list.current_q)
      result = @num_list.delete(new_fixed_point)
      if result
        "#{new_fixed_point} was deleted from the list."
      else
        "No value equal to #{new_fixed_point} in the list."
      end
    else
      'Arg missing. You must specify the number to append to the list'
    end
  end

  private :handle_command, :handle_add, :handle_delete, :handle_q_change
end
