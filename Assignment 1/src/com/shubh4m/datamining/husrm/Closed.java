package com.shubh4m.datamining.husrm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;

public class Closed extends HUSRM {
    private class WriteData {
        int[] antecedent;
        int[] consequent;
        double utility;
        double support;
        double confidence;

        WriteData(int[] a, int[] c, double u, double s, double cnf) {
            this.antecedent = a;
            this.consequent = c;
            this.utility = u;
            this.support = s;
            this.confidence = cnf;
        }
    }

    private ArrayList<WriteData> data = null;

    public Closed() {
        data = new ArrayList<>();
    }

    protected void saveRule(int[] antecedent, int[] consequent,
                          double utility, double support, double confidence) throws IOException {
        ruleCount++;
        data.add(new WriteData(antecedent, consequent, utility, support, confidence));
    }

    public void runAlgorithm(String input,
                             String output,
                             double minConfidence,
                             double minutil,
                             int maxAntecedentSize,
                             int maxConsequentSize,
                             int maximumNumberOfSequences) throws IOException {
        super.runAlgorithm(input,
                output,
                minConfidence,
                minutil,
                maxAntecedentSize,
                maxConsequentSize,
                maximumNumberOfSequences);
        // close output file
        writeOutFinal();
        writer.close();
    }

    private void writeOutFinal() throws IOException {
        ArrayList<WriteData> toRemove = new ArrayList<WriteData>();

        for (int i = 0; i < data.size(); i++) {
            for (int j = i + 1; j < data.size(); j++) {
                Set<Integer> iSet = new HashSet<Integer>();
                Set<Integer> jSet = new HashSet<Integer>();

                for(int x : data.get(i).antecedent) {
                    iSet.add(x);
                }
                for(int x : data.get(j).antecedent) {
                    jSet.add(x);
                }
                for(int x : data.get(i).consequent) {
                    iSet.add(x);
                }
                for(int x : data.get(j).consequent) {
                    jSet.add(x);
                }

                if (iSet.containsAll(jSet) && data.get(i).support == data.get(j).support) {
                    toRemove.add(data.get(j));
                }
                if (jSet.containsAll(iSet) && data.get(i).support == data.get(j).support) {
                    toRemove.add(data.get(i));
                }
            }
        }

        data.removeAll(toRemove);

        for (WriteData w : data) {
            super.saveRule(w.antecedent, w.consequent, w.utility, w.support, w.confidence);
        }
    }
}
