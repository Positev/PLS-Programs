import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class FixedPointListTest {

    @Test
    void testRunTimeCommands() {
        ArrayList<String> commands = new ArrayList<String>();
        commands.add("P");
        commands.add("S");
        commands.add("Q 9");
        commands.add("A 123.46");
        commands.add("a 123.49");
        commands.add("Q 17");
        commands.add("a 123.4");
        commands.add("P");
        commands.add("S");
        commands.add("D 123.46");
        commands.add("Q 9");
        commands.add("A 123.49");
        commands.add("P");
        commands.add("D 123.49");
        commands.add("P");
        commands.add("Q 15");
        commands.add("A 123.5");
        commands.add("P");
        commands.add("S");
        commands.add("A 43.3101");
        commands.add("A 12.5");
        commands.add("A 1.2");
        commands.add("A 43.31");
        commands.add("P");
        commands.add("S");
        commands.add("C 3.520");
        commands.add("X");

        ArrayList<String> correctOutputs = new ArrayList<String>();
        correctOutputs.add("All fixed-point numbers in the list are:");
        correctOutputs.add("The sum is 0, 12: 0.000000.");
        correctOutputs.add("Current q_value was changed to 9.");
        correctOutputs.add("63211, 9: 123.458984 was added to the list.");
        correctOutputs.add("63226, 9: 123.488281 was added to the list.");
        correctOutputs.add("Current q_value was changed to 17.");
        correctOutputs.add("16174284, 17: 123.399994 was added to the list.");
        correctOutputs.add("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n63226, 9: 123.488281\n16174284, 17: 123.399994");
        correctOutputs.add("The sum is 48542156, 17: 370.347260.");
        correctOutputs.add("No value equal to 16182149, 17: 123.459999 in the list.") ;
        correctOutputs.add("Current q_value was changed to 9.");
        correctOutputs.add("63226, 9: 123.488281 was added to the list.");
        correctOutputs.add("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n63226, 9: 123.488281\n16174284, 17: 123.399994\n63226, 9: 123.488281");
        correctOutputs.add("63226, 9: 123.488281 was deleted from the list.");
        correctOutputs.add("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281");
        correctOutputs.add("Current q_value was changed to 15.");
        correctOutputs.add("4046848, 15: 123.500000 was added to the list.");
        correctOutputs.add("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281\n4046848, 15: 123.500000");
        correctOutputs.add("The sum is 16182387, 15: 493.847260.");
        correctOutputs.add("1419185, 15: 43.310089 was added to the list.");
        correctOutputs.add("409600, 15: 12.500000 was added to the list.");
        correctOutputs.add("39321, 15: 1.199982 was added to the list.");
        correctOutputs.add("1419182, 15: 43.309998 was added to the list.");
        correctOutputs.add("All fixed-point numbers in the list are:\n63211, 9: 123.458984\n16174284, 17: 123.399994\n63226, 9: 123.488281\n4046848, 15: 123.500000\n1419185, 15: 43.310089\n409600, 15: 12.500000\n39321, 15: 1.199982\n1419182, 15: 43.309998");
        correctOutputs.add("The sum is 19469675, 15: 594.167328.");
        correctOutputs.add("C is not a valid command!");
        correctOutputs.add("Normal termination of program1.");



        FixedPointList fpl = new FixedPointList();
        for (int i = 0; i < commands.size(); i++) {

            String command = commands.get(i);

            String actualOutput = fpl.keyboardCommand(command);

            String output = correctOutputs.get(i);
            assertEquals( output, actualOutput, String.format("Command: %s", command));

        }




    }

}