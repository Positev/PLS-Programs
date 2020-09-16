import com.sun.deploy.net.proxy.ProxyUnavailableException;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Scanner;

public class FixedPointList {

    private ArrayList<FixedPointNumber> fixedPointList = new ArrayList<>();
    private int currentQ = 12;


    public static void main(String[] args) {
        FixedPointList fpl = new FixedPointList();
        fpl.run();
    }

    public void run(){
        String response;
        Scanner scanner = new Scanner(System.in);
        do {
            response = keyboardCommand(scanner.nextLine());
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
    protected String keyboardCommand(String line){
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


    protected String handleCommand(String command){
        switch (command.toLowerCase()){
            case "a":{
                return "Arg missing. You must specify the number to delete from the list";
            }
            case "q":{
                return "Arg missing. You must specify the new q value";
            }
            case "d": {
                return "Arg missing. You must specify the number to append to the list";
                }
            case "p":{
                StringBuilder out = new StringBuilder();
                out.append("All fixed-point numbers in the list are:");
                fixedPointList.forEach((num)-> out.append("\n").append(num.toString()));
                return out.toString();
                }
            case "s":{
                return "The sum is " + this.sumAll().toString() + ".";
                }
            case "x":{
                return "Normal termination of program1.";
                }
            default:{
                return command + " is not a valid command!";
            }
        }


    }

    public String handleCommand(String command, String arg){

        switch (command.toLowerCase()){
            case "a":{

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, currentQ);
                add(num);
                return num.toString() + " was added to the list.";
            }
            case "d":{

                double dArg = Double.parseDouble(arg);
                FixedPointNumber num = new FixedPointNumber(dArg, currentQ);
                boolean result = delete(num);

                if(result){
                    return num.toString() + " was deleted from the list.";
                }
                else{
                    return "No value equal to " + num.toString() + " in the list.";
                }
            }
            case "q": {
                this.currentQ = Integer.parseInt(arg);
                return "Current q_value was changed to " + this.currentQ + ".";
            }
            case "p": case "s": case "x":{
                return handleCommand(command);
            }
            default:{
                return command + " is not a valid command!";
            }
        }
    }

    public void add(FixedPointNumber p){
        fixedPointList.add(p);
    }

    public boolean delete(FixedPointNumber p){
        for (int i = 0; i < fixedPointList.size(); i++) {
            FixedPointNumber currentNum = fixedPointList.get(i);
            if(p.equals(currentNum)){
                fixedPointList.remove(currentNum);
                return true;
            }
        }
        return false;
    }

    public void print(){

        // While this is available for use due to requirements, It is not used because the current implementation
        // was more convenient for testing. That testing strategy defined how i implemented the
        // rest of program, so it is never used or needed.

        System.out.println("All fixed-point numbers in the list are:");
        fixedPointList.forEach((num)-> System.out.println(num.toString()));

    }

    public FixedPointNumber sumAll(){
        FixedPointNumber summed = new FixedPointNumber(0,currentQ);
        ArrayList<FixedPointNumber> sums = new ArrayList<>();
        for (FixedPointNumber num : this.fixedPointList) {
            summed = summed.plus(num, this.currentQ);
            sums.add(num);
        }
        return summed;
    }

}
