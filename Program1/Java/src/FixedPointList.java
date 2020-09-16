import java.util.ArrayList;
/**
 * The requirements for Program 1 force the Fixed point list to violate the single responsibility principal. So i
 * decided to separate the responsibility of handing user input to the FixedPointListCommandLineInterface class. This
 * class is not solely responsible for managing a list of fixed point numbers. Avaliable operations are adding, deleting,
 * and summing. The Q value is also available for mutation.
 *
 * @author Trevor Keegan
 * @date 9/16/2020
 * */
public class FixedPointList {

    private ArrayList<FixedPointNumber> fixedPointList = new ArrayList<>();
    private int currentQ = 12;

    /**
     * Get current Q value
     * @return current Q value
     * */
    public int getCurrentQValue(){
        return currentQ;
    }

    /**
     * Set current Q value
     * @param q - new Q value
     * */
    public void setCurrentQValue(int q){
        this.currentQ = q;
    }

    /**
     * add fixed point number to list
     * @param p - new fixed point number
     * */
    public void add(FixedPointNumber p){
        fixedPointList.add(p);
    }

    /**
     * delete first instance of fixed point number from list.
     * Match determined by deep equality, not reference.
     * @param p - new fixed point number
     * @return true if delete, false if not in list
     * */
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
    /**
     * Print list to console with display message
     * */
    public void print(){

        // While this is available for use due to requirements, It is not used because the current implementation
        // was more convenient for testing. That testing strategy defined how i implemented the
        // rest of program, so it is never used or needed.

        System.out.println("All fixed-point numbers in the list are:");
        System.out.println(this.toString());

    }
    /**
     * Represent list of Fixed point numbers as string.
     * */
    public String toString(){
        StringBuilder builder = new StringBuilder();
        fixedPointList.forEach((num)-> builder.append('\n').append(num.toString()));
        return builder.toString();
    }

    /**
     * Represent list of Fixed point numbers as string.
     * */
    public FixedPointNumber sumAll(){
        FixedPointNumber summed = new FixedPointNumber(0,currentQ);
        for (FixedPointNumber num : this.fixedPointList) {
            summed = summed.plus(num, this.currentQ);
        }
        return summed;
    }

}
