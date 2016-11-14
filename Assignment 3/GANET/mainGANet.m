

function CC = mainGANet(fileinput,alfa,fileclass,numclass)

%Author: Clara Pizzuti email:pizzuti at icar.cnr.it

%MainGANet executes the GA-NET algorithm 
%fileinput: list of edges of the graph

%alfa: input parameter corresponding to the exponent r of community score

%fileclass: if the true partitioning is known it is possible to compute the Normalized
%Mutual information
%numclass: number of true communities

if nargin >=2
    
edges=load(fileinput);

%set parameters for the GA
mutationRate=0.2;
CrossoverFraction=0.8;
maxGen=50;  %max number of generations
PopSize=50; %population size

CC=ganet(edges,alfa,mutationRate,CrossoverFraction,maxGen,PopSize)

[fid, message] = fopen('ris.txt','wt');
%the list of communities found by GA-NET are stored,  one community for line, in
%the file ris.txt
for i1 = 1:size(CC,2)
    listnodes=CC{i1};
    for j1= 1:size(listnodes,2)
       
            fprintf(fid,'%d ',listnodes(j1));
    end
    fprintf(fid,'\n');
end
      if nargin ==4
          
      class=load(fileclass);
      numnodes=size(class,1)
      CM=confusionMatrix(CC,class,numclass) %generate the confusion matrix
      NMI = computeNMI(CM,numnodes)
      end
else
    error('not enough input parameters')
end

end




function CM= confusionMatrix(CC,classi,numclass)

%classi = load(filein);

CM = zeros(numclass,size(CC,2));

for k=1:size(CC,2) %
   
    listnodes=CC{k};
    for j = 1: size(listnodes,2)
    nodo = listnodes(j);
          if (nodo~=0)
              classe = classi(nodo,2);
              
              CM(classe,k)=  CM(classe,k)+1;
          end
    end
end
end