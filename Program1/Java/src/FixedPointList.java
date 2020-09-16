import java.util.ArrayList;
import java.util.Scanner;

public class FixedPointList {

    private ArrayList<FixedPointNumber> fixedPointList = new ArrayList<>();
    private int currentQ = 12;

    public int getCurrentQValue(){
        return currentQ;
    }

    public void setCurrentQValue(int q){
        this.currentQ = q;
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
        System.out.println(this.toString());

    }

    public String toString(){
        StringBuilder builder = new StringBuilder();
        fixedPointList.forEach((num)-> builder.append('\n').append(num.toString()));
        return builder.toString();
    }

    public FixedPointNumber sumAll(){
        FixedPointNumber summed = new FixedPointNumber(0,currentQ);
        for (FixedPointNumber num : this.fixedPointList) {
            summed = summed.plus(num, this.currentQ);
        }
        return summed;
    }

}
