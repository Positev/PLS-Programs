public class FixedPointNumber {
    private int intVal;
    private int qVal;

    public FixedPointNumber(double x, int q){
        double dval = (x *  Math.pow(2,q));
        intVal = (int)(dval);
        this.qVal = q;
    }

    public FixedPointNumber(int x, int q){
        this.intVal = x;
        this.qVal = q;
    }

    public double toDouble(){
        return (double) this.intVal / Math.pow(2, this.qVal);

    }

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

    @Override
    public String toString(){
        return String.format("%d, %d: %.6f",intVal, qVal, toDouble());
    }

    public boolean equals(Object p){
        if(p.getClass() != this.getClass()){
            return false;
        }
        FixedPointNumber num = (FixedPointNumber )p;
        return this.intVal == num.intVal && this.qVal == num.qVal;
    }

    public FixedPointNumber plus(FixedPointNumber p, int resultQ){
        FixedPointNumber thisConverted = this.toQVal(resultQ);
        FixedPointNumber otherConverted = p.toQVal(resultQ);

        return new FixedPointNumber(thisConverted.intVal + otherConverted.intVal, resultQ);

    }
}
