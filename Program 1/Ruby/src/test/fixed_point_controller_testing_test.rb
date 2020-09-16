require 'minitest/autorun'

require '../FixedPointListController'
fplc = FixedPointListController.new()

commands = []
commands.push("P")
commands.push("S")
commands.push("Q 9")
commands.push("A 123.46")
commands.push("a 123.49")
commands.push("Q 17")
commands.push("a 123.4")
commands.push("P")
commands.push("S")
commands.push("D 123.46")
commands.push("Q 9")
commands.push("A 123.49")
commands.push("P")
commands.push("D 123.49")
commands.push("P")
commands.push("Q 15")
commands.push("A 123.5")
commands.push("P")
commands.push("S")
commands.push("A 43.3101")
commands.push("A 12.5")
commands.push("A 1.2")
commands.push("A 43.31")
commands.push("P")
commands.push("S")
commands.push("C 3.520")
commands.push("X")

correct_outputs = []
correct_outputs.push("All fixed-point numbers in the list are:")
correct_outputs.push("The sum is 0, 12: 0.000000.")
correct_outputs.push("Current q_value was changed to 9.")
correct_outputs.push("63211, 9: 123.458984 was added to the list.")
correct_outputs.push("63226, 9: 123.488281 was added to the list.")
correct_outputs.push("Current q_value was changed to 17.")
correct_outputs.push("16174284, 17: 123.399994 was added to the list.")
correct_outputs.push("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n63226, 9: 123.488281\n16174284, 17: 123.399994")
correct_outputs.push("The sum is 48542156, 17: 370.347260.")
correct_outputs.push("No value equal to 16182149, 17: 123.459999 in the list.")
correct_outputs.push("Current q_value was changed to 9.")
correct_outputs.push("63226, 9: 123.488281 was added to the list.")
correct_outputs.push("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n63226, 9: 123.488281\n16174284, 17: 123.399994\n63226, 9: 123.488281")
correct_outputs.push("63226, 9: 123.488281 was deleted from the list.")
correct_outputs.push("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281")
correct_outputs.push("Current q_value was changed to 15.")
correct_outputs.push("4046848, 15: 123.500000 was added to the list.")
correct_outputs.push("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281\n4046848, 15: 123.500000")
correct_outputs.push("The sum is 16182387, 15: 493.847260.")
correct_outputs.push("1419185, 15: 43.310089 was added to the list.")
correct_outputs.push("409600, 15: 12.500000 was added to the list.")
correct_outputs.push("39321, 15: 1.199982 was added to the list.")
correct_outputs.push("1419182, 15: 43.309998 was added to the list.")
correct_outputs.push("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281\n4046848, 15: 123.500000\n1419185, 15: 43.310089\n409600, 15: 12.500000\n39321, 15: 1.199982\n1419182, 15: 43.309998")
correct_outputs.push("The sum is 19469675, 15: 594.167328.")
correct_outputs.push("C is not a valid command!")
correct_outputs.push("Normal termination of program1.")


class FixedPointControllerTestingTest < MiniTest::Unit::TestCase


  def test
    (0...commands.size).each { |i|
      puts commands[i]
      assert_equal fplc.execute(commands[i]), correct_outputs[i]
    }
  end
end