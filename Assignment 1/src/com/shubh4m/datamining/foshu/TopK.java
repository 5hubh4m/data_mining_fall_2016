package com.shubh4m.datamining.foshu;

import com.shubh4m.datamining.uspan.USpan;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;

public class TopK extends FOSHU {
    private int k = 0;

    public TopK(int k) {
        this.k = k;
        this.data = new ArrayList<WriteData>();
    }

    class WriteData implements Comparator<WriteData> {
        int[] prefix = null;
        int item = 0;
        int utility = 0;
        double relativeUtility;

        WriteData() {}

        WriteData(int[] p, int it, int util, double rutil) {
            this.prefix = p;
            this.relativeUtility = rutil;
            this.item = it;
            this.utility = util;
        }

        public int compare(WriteData w1, WriteData w2) {
            if (w1.utility < w2.utility)
                return 1;
            else if (w1.utility > w2.utility)
                return -1;
            else
                return 0;
        }
    }

    private ArrayList<WriteData> data = null;

    void writeOut(int[] prefix, int item, int utility, double relativeUtility) throws IOException {
        huiCount++;

        data.add(new WriteData(prefix, item, utility, relativeUtility));
    }

    private void writeOutFinal() throws IOException {
        data.sort(new WriteData());

        int i = 0;
        for(WriteData d : data) {
            if (i < k) {
                super.writeOut(d.prefix, d.item, d.utility, d.relativeUtility);
                i++;
            } else
                break;
        }
    }


    public void runAlgorithm(String input, String output, double minUtilityR) throws IOException {
        super.runAlgorithm(input, output, minUtilityR);
        writeOutFinal();

        // close output file
        writer.close();
    }
}
