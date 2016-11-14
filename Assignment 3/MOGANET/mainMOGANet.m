%It executes MOEAGA-NET for a number of data sets equals to maxnum
function mainTest = mainMOGANet(fileinput,alfa,fileclassi,numclassi)
%%%%%%%%%%%%%%%%%%%%%%
%Author: Clara Pizzuti email:pizzuti at icar.cnr.it

%MainMOGANet executes the MOGA-Net algorithm 
%fileinput: list of edges of the graph

%alfa: input parameter corresponding to the exponent r of community score

%fileclass: if the true partitioning is known it is possible to compute the Normalized
%Mutual information
%numclass: number of true communities
%the program genetates two output files: fileinput.ris containing average
%results obtained by running the method numIter times, and fileinput.sol,
%containing the clustering computed by the method.


fileout=sprintf('%s.ris',fileinput);

[fid, message] = fopen(fileout,'wt');


%set parameters for the multiobjective GA
mutationRate=0.2;
CrossoverFraction=0.8;
maxGen=50;  %max number of generations
PopSize=30; %population size
numIter=1;     %number of iteration the algoritm is executed

if nargin  <2
    disp('not enough parameters')
    return;
else
    if nargin == 2
       numclassi=0;
       fileclassi=' '; 
       MOGANet(fileinput,alfa,fileclassi,numclassi,mutationRate,CrossoverFraction,maxGen,PopSize,numIter);
    
    else
    if nargin ==4
       MOGANet(fileinput,alfa,fileclassi,numclassi,mutationRate,CrossoverFraction,maxGen,PopSize,numIter) 

    else
        disp('wrong number of parameters')       
    end
    end
end
end
