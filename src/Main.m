%This file is for automatic clustering of the Distribution test network

clc
clear all
close all

%%
%Load workspace
%%load('Workspace1.mat');


%%
%get lines connection names
%FileName='Lines.dss';
%ConnetionLines = ConnectionLinesFunction(FileName);
ConnetionLines = ReadBusModified;

%%
%Clustering result
Clusters{1,1}=0; %Initiate the cells
Overlap{1,1}=0;  %Overlap cells
%%
%parameters

%Total number of the clusters
NumberClusters=50;  

%Threshold for the buses of each cluster
Threshold=1;

%Source Bus Name
%SOURCEBUS='substation_s2_s_nssee1_1247_node2';
SOURCEBUS='st_root_c8';


%Residual
Residual=2;


%%
%Check the file accuracy and modify****************

%Remove same lines of connection matrix----------------------
ConnetionLines=RemoveSameLinesFunction(ConnetionLines);

%Remove Secondary Transformer and loads-----------------------
%Connection=SecondaryRemoveFunction(Connection);

%Remove loops and Modify parent and children places--------------------------
ConnectionTemp=ModifyConnectionFunction2(ConnetionLines, SOURCEBUS);
ConnetionLines = ConnectionTemp{1,1};
Initial_Layer = ConnectionTemp{1,2};

%%
%Read OpenDSS Line code file
%First colum shows Bus1
%Second column shows Bus2
%Third column shows weight of the line between Bus1 and Bus2
%Connection=ReadBus;
Connection=ConnetionLines;
for i=1:size(Connection,1)
    Connection{i,3} = 1;
end
%%


Connection=RemoveSameLinesFunction(Connection);
check=CheckConnection(Connection);


disp(check{1,1});
disp(check{1,2});


%%
%Primary connection
ConnectionPrimary=Connection;

%%
%Find the remaining unclustered Lines or buses
%RemainingLines=RemainedBuses(ConnectionPrimary,ConnetionLines);

%%
stop=0;
t=0;
%Clustering cycle
while 1

  if stop==1
      break; 
  end
%%
%Create Layers Matrix

%Total Line numbers
LineNum=size(Connection);
LineNum=LineNum(1,1);

%Layers creation function
if t == 0
    Layers = Initial_Layer
else
    Layers=LayerFunction(Connection,LineNum,SOURCEBUS);
end

LayersNum=size(Layers);
LayersNum=LayersNum(1,1);

%%
%Sequence matrix
%First column is the Bus name
%Second column is its parent 
%Third column shows its aggregated weight (Here number of buses in lower layers)

Sequence=SequenceFunction(Connection,Layers,LayersNum,LineNum);

% %%--------------------------------------------------------************
% %index=strcmpi('l2989596',Layers);
% index=strcmpi('181901',Sequence);
% %index=strcmpi('181901',Clusters);
% %removed in t==17
% for i=1:size(index,1)
%    for j=1:size(index,2)
%       
%        if index(i,j)==1
%            disp('New New');
%            disp(t);
%            disp(i);
%            disp(j);
%        end
%        
%    end
% end
% if t==17
%     disp(t);
% end
%%----------------------------------------------------*******************
t=t+1;
if t==1
    NodeNum_InEachCluster=LineNum/NumberClusters;
    NodeNum_InEachCluster=round(NodeNum_InEachCluster);
    SequencePrimary=Sequence;
end
%%
%Clustering function
ClustersNew=ClusterFunction(Clusters,Sequence,NodeNum_InEachCluster,NumberClusters,Threshold,Residual,Overlap);
Clusters=ClustersNew{1,1};
NewClusters=ClustersNew{1,2};
stop=ClustersNew{1,3};
Residual=ClustersNew{1,4};
Overlap=ClustersNew{1,5};

%%
%Remove clustered buses
if stop==0
Connection=RemoveClusteredFunction(Clusters,Connection,NewClusters,LineNum);
end
%%
%end of clustering cycle
% stop=size(Clusters);
% stop=stop(1,1);
end

%display residual of whole clustering algorithm
disp(Residual);

%obtain lines name between buses, used later for generating dss script
%Lines=ConnectionLinesFunction(FileName);

%integrating overlap clusters with other clustering results
%Clusters=IntegrateOverlapFunction(Clusters,Overlap);

%Save cluster into a .mat file
File = "C:\Users\re208655\Desktop\NREL_C8\Restoration\Version4_C2\TestNetwork\Clusters.mat";
save(File, 'Clusters');









