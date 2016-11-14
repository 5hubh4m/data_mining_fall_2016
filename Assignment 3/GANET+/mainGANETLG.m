

function CC = mainGANETLG(fileinput,alfa,fileclass,numclass)
%Author: Clara Pizzuti email:pizzuti at icar.cnr.it

%ganetplus executes the algorithm GA-NET+ on the line graph 
%fileinput: list of edges of the graph, only one of (i,j) or  (j,i) must be
%present

%alfa: input parameter corresponding to the exponent of community score
%if you know the number of true classes and the true membership of each
%node you can compute the confusion matrix by giving in iput fileclass and
%numclass

if nargin >=2
    
edgesLG=buildLineGraph(fileinput); %compute the line graph and store it fileinput.lg 
% 
disp('line graph built and stored in fileinput.lg')
edges=load(fileinput);

%set parameters for the GA
mutationRate=0.2;
CrossoverFraction=0.8;
maxGen=50;  %max number of generations
PopSize=50; %population size

CC=ganetplus(edges,edgesLG,alfa,mutationRate,CrossoverFraction,maxGen,PopSize)

[fid, message] = fopen('ris.txt','wt'); %prints the obtained communities one for row, in the file ris.txt 
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
      end
else
    error('not enough input parameters')
end

end




function CM= confusionMatrix(CC,classi,numclass)

CM = zeros(numclass,size(CC,2));

for k=1:size(CC,2) 
   
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