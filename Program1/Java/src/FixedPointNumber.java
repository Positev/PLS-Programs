/**
 * The fixed point number, as opposed to floating point number takes advantage of mathematics to represent a decimal
 * number on hardware that might not support floating point numbers.
 *
 * @author Trevor Keegan
 * @date 9/16/2020
 * */

public class FixedPointNumber {
    private int intVal;
    private int qVal;

    /**
     * Constructor to take a double number with a q value and create fixed point number by calculating the int value
     * @param x double to be converted to Fixed point number at desired q
     * @param q desired q value to create new fixed point number at
     * */
    public FixedPointNumber(double x, int q){
        intVal = (int) (x *  Math.pow(2,q));
        this.qVal = q;
    }
    /**
     * Constructor to take a double number with a q value and create fixed point number by calculating the int value
     * @param x integer to be set as int val. No manipulation occurs.
     * @param q correct q value to get desired double value after conversion using supplied x
     * */
    public FixedPointNumber(int x, int q){
        this.intVal = x;
        this.qVal = q;
    }

    /**
     * convert Fixed point number back to double
     * @return fixed point number as double
     * */
    public double toDouble(){
        return (double) this.intVal / Math.pow(2, this.qVal);

    }
    /**
     *  convert this fixed point number to a new fixed point number with a different q such that the decimal value are
     *  exactly the same
     *
     * @param q new desired q value
     * @return new fixed point number with desired q value
     * */
    public FixedPointNumber toQVal(int q){
        int qDiff = q - this.qVal;
        int newIntVal;
        if(qDiff > 0){
            newIntVal = this.intVal << Math.abs(qDiff);
        }
        else {
            newIntVal = this.intVal >> Math.abs(qDiff);
        }

        return new FixedPointNumber(newIntVal,q);
    }
    /**
     * serialize the Fixed point integer to string
     * @return  string representation of Fixed point number
     * */
    @Override
    public String toString(){
        return String.format("%d, %d: %.6f",intVal, qVal, toDouble());
    }

    /**
     * deep equality check for Fixed point number.
     * @return true if and only if
     *          : other object is also Fixed point number
     *          : int value is exactly the same for this and other
     *          : q value is exactly the same for this and other
     *
     * */
    public boolean equals(Object p){
        if(p.getClass() != this.getClass()){
            return false;
        }
        FixedPointNumber num = (FixedPointNumber )p;
        return this.intVal == num.intVal && this.qVal == num.qVal;
    }

    /**
     * sum this Fixed point number with another fixed point number at a
     * desired q value.
     *
     * @param resultQ Desired result Q to get returned value in
     * @param p Number to sum with this object
     * @return  new Fixed point number at result Q
     * */
    public FixedPointNumber plus(FixedPointNumber p, int resultQ){
        FixedPointNumber thisConverted = this.toQVal(resultQ);
        FixedPointNumber otherConverted = p.toQVal(resultQ);

        return new FixedPointNumber(thisConverted.intVal + otherConverted.intVal, resultQ);

    }
}
