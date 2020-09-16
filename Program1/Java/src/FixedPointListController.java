import java.util.Scanner;

public class FixedPointListController {
    FixedPointList fixedPointList;
    public FixedPointListController(){
        fixedPointList = new FixedPointList();


    }
    public static void main(String[] args) {
        FixedPointListController controller = new FixedPointListController();
        controller.run();
    }

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
     * to other handlers.
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


    private String handleCommand(String command){
        switch (command.toLowerCase()) {
            case "a" -> {
                return "Arg missing. You must specify the number to delete from the list";
            }
            case "q" -> {
                return "Arg missing. You must specify the new q value";
            }
            case "d" -> {
                return "Arg missing. You must specify the number to append to the list";
            }
            case "p" -> {
                return "All fixed-point numbers in the list are:" + fixedPointList.toString();

            }
            case "s" -> {
                return "The sum is " + fixedPointList.sumAll().toString() + ".";
            }
            case "x" -> {
                return "Normal termination of program1.";
            }
            default -> {
                return command + " is not a valid command!";
            }
        }


    }

    private String handleCommand(String command, String arg){

        switch (command.toLowerCase()) {
            case "a" -> {

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, fixedPointList.getCurrentQValue());
                fixedPointList.add(num);
                return num.toString() + " was added to the list.";
            }
            case "d" -> {

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, fixedPointList.getCurrentQValue());
                boolean result = fixedPointList.delete(num);

                if (result) {
                    return num.toString() + " was deleted from the list.";
                } else {
                    return "No value equal to " + num.toString() + " in the list.";
                }
            }
            case "q" -> {
                int newQ = Integer.parseInt(arg);
                fixedPointList.setCurrentQValue(newQ);
                return "Current q_value was changed to " + fixedPointList.getCurrentQValue() + ".";
            }
            case "p", "s", "x" -> {
                return handleCommand(command);
            }
            default -> {
                return command + " is not a valid command!";
            }
        }
    }
}
