import java.util.Scanner;

/**
 * The requirements for Program 1 force the Fixed point list to violate the single responsibility principal. So i
 * decided to separate the responsibility of handing user input to this class. This class is used to interact with
 * the user via keyboard and console. It is also used for testing via FixedPointControllerTest.
 *
 * @author Trevor Keegan
 * @date 9/16/2020
 * */
public class FixedPointListCommandLineInterface {
    FixedPointList fixedPointList;


    /**
     * Construct a new instance and initialize the Fixed Point List to be used.
     *
     * */
    public FixedPointListCommandLineInterface(){
        fixedPointList = new FixedPointList();
    }

    /**
     * Run this to begin command line interaction with user
     *
     * */
    public static void main(String[] args) {
        FixedPointListCommandLineInterface controller = new FixedPointListCommandLineInterface();
        controller.run();
    }

    /**
     * This function enters into a loop with the user via keyboard and console to
     * allow them to execute commands.
     *
     * */
    public void run(){
        String response;
        Scanner scanner = new Scanner(System.in);
        do {
            response = execute(scanner.nextLine());
            System.out.print(response + '\n');

        }
        while (!response.equals("Normal termination of program1."));
    }


    /**
     * Handle raw line from keyboard. Will remove carriage return before passing
     * to other handlers. Will also parse args and command from line is single space
     * between them.
     *
     * @param line - Raw input from keyboard. -> scanner.readLine()
     * @return Response from system to display to user
     * */
    public String execute(String line){
        line = line.replace("\n", "");
        if(line.contains(" "))
        {
            int indexOfSpace = line.indexOf(" ");
            String args = line.substring(indexOfSpace + 1);
            String commandOnly = line.substring(0,indexOfSpace);

            return this.handleCommand(commandOnly, args);
        }
        else
        {
            return  this.handleCommand(line);
        }
    }

    /**
     * Handle parsed command from execute function. Specifically commands
     * that do not include an arguement as provided from input to execute.
     *
     * If trying to use command that requires arg with no args, error message will be displayed to user.
     *
     * @param command - parsed command. Valid entries are ["P", "S", "X"] or lower case equivalent,
     * All other entries will return an error message
     * @return Response from system to display to user
     * */
    private String handleCommand(String command){
        switch (command.toLowerCase()) {
            case "a": {
                return "Arg missing. You must specify the number to delete from the list";

            }
            case "q" : {
                return "Arg missing. You must specify the new q value";
            }
            case "d" : {
                return "Arg missing. You must specify the number to append to the list";
            }
            case "p" : {
                return "All fixed-point numbers in the list are:" + fixedPointList.toString();

            }
            case "s" : {
                return "The sum is " + fixedPointList.sumAll().toString() + ".";
            }
            case "x" : {
                return "Normal termination of program1.";
            }
            default: {
                return command + " is not a valid command!";
            }
        }


    }

    /**
     * Handle parsed command from execute function. Specifically commands
     * that do include an argument as provided from input to execute.
     *
     * If using command that does not require arg with an arg, it is ignored and
     * handle command designed for no args will be deferred to.
     *
     * @param command - Raw input from keyboard. -> scanner.readLine()
     * @return Response from system to display to user
     * */
    private String handleCommand(String command, String arg){

        switch (command.toLowerCase()) {
            case "a" : {

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, fixedPointList.getCurrentQValue());
                fixedPointList.add(num);
                return num.toString() + " was added to the list.";
            }
            case "d" :{

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, fixedPointList.getCurrentQValue());
                boolean result = fixedPointList.delete(num);

                if (result) {
                    return num.toString() + " was deleted from the list.";
                } else {
                    return "No value equal to " + num.toString() + " in the list.";
                }
            }
            case "q" : {
                int newQ = Integer.parseInt(arg);
                fixedPointList.setCurrentQValue(newQ);
                return "Current q_value was changed to " + fixedPointList.getCurrentQValue() + ".";
            }
            case "p":
            case "s":
                case "x" : {
                return handleCommand(command);
            }
            default : {
                return command + " is not a valid command!";
            }
        }
    }
}
