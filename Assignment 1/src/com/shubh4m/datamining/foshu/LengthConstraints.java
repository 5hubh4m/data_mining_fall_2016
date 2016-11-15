package com.shubh4m.datamining.foshu;

import java.io.IOException;

public class LengthConstraints extends FOSHU {
    private int minLength = 0;
    private int maxLength = Integer.MAX_VALUE;

    public LengthConstraints(int minLength, int maxLength) {
        this.minLength = minLength;
        this.maxLength = maxLength;
    }

    protected void writeOut(int[] prefix, int item,  int utility, double relativeUtility) throws IOException {
        if (prefix.length >= minLength && prefix.length <= maxLength) {
            super.writeOut(prefix, item, utility, relativeUtility);
        } else {
            huiCount++;
        }
    }
}
