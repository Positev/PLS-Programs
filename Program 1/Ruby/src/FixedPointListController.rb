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

    if(has_arg)
      split_command = command.split(' ')
      command = split_command[0]
      response = handle_command(command, split_command[1] )
    else
      response = handle_command(command)
    end

    return response
  end

  def handle_command(command, arg = nil)
    command = command.downcase
    if command == 'a'
      return handle_add(arg)
    elsif command == 'q'
      return handle_q_change(arg)
    elsif command == 'd'
      return handle_delete(arg)
    elsif command == 'p'
      entries = "#{@num_list.to_s}"
      if entries != ""
        return "All fixed-point numbers in the list are:\n#{entries}"
      end
      return "All fixed-point numbers in the list are:"
    elsif command == 's'
      return "The sum is #{@num_list.sum_all}."
    elsif command == 'x'
      return "Normal termination of program1."
    else
      return"#{command} is not a valid command!"
    end
  end

  def handle_add(arg)
    if(arg != nil)
      new_fixed_point = FixedPointNumber.new(arg.to_f, @num_list.current_q)
      @num_list.add(new_fixed_point)
      return "#{new_fixed_point.to_s} was added to the list."
    else
      return "Arg missing. You must specify the number to append to the list"
    end
  end

  def handle_q_change(arg)
    if(arg != nil)
      @num_list.current_q = arg.to_i
      return "Current q_value was changed to #{@num_list.current_q}."
    else
      return "Arg missing. You must specify the new q value"
    end
  end

  def handle_delete(arg)
    if(arg != nil)
      new_fixed_point = FixedPointNumber.new(arg.to_f, @num_list.current_q)
      result = @num_list.delete(new_fixed_point)
      if result
        return "#{new_fixed_point.to_s} was deleted from the list."
      else
        return "No value equal to #{new_fixed_point.to_s} in the list."
      end
    else
      return "Arg missing. You must specify the number to append to the list"
    end
  end

end
