clc
clear all
close all
%This code is for generating Fmonitor script which is used in OpenDSS

%%
load('WorkSpace1.mat');

%Source Bus Name
%SOURCEBUS='substation_s2_s_nssee2_1247_node19';

%Clustering Start point
StartClustering=271;
%-----------------------
strID = "1";
%mydir =  'C:\Users\Reza\Desktop\ThisComputer\PhD_Studies\DOE Project\Clustering\simulation\11k-Node\Edition2(Ymatrix)\OpenDSS script';
%fm_dss = strcat(mydir,"fm_11k",strID,".dss");
fid_fm = fopen('Fmonitor_ckt4_F1.dss','wt');
%%
ClusterNum=size(Clusters,1);
for i=1:ClusterNum
row =i;
Nodes=RowSizeFunction(Clusters,row);
Cluster_num = row+StartClustering;
rootbus = Clusters(row,1);  % assume this is the root of subtree.
strLineName=FindLineFunction2(rootbus,Lines,SequencePrimary,SOURCEBUS);
strLineName=strrep(strLineName,'"','');
str = 'New Fmonitor.FM%d element=%s terminal=%d P_trans_ref=%f P_mode=%d ppolar=no  Cluster_num=%d Nodes=%d';
% Cluster_num = 1;
% strLineName= 'Line.L115'; 
t_num = 2;
p_trans_ref = 0;
p_mode = 0;
% Nodes =58;
[strFm,errmsg] = sprintf(str, Cluster_num,strLineName,t_num,p_trans_ref,p_mode,Cluster_num,Nodes);

fprintf(fid_fm,'%6s\n',strFm);
if i==ClusterNum
   fprintf(fid_fm,'%6s\n',"  "); 
end
end


%% scripts of nodes
for i=1:ClusterNum

    Nodes=RowSizeFunction(Clusters,i);
    clusterNum=i+StartClustering;
    for j=1:Nodes
        str = 'Fmonitor.FM%d.ElemTableLine={%d,  %s,  %s,   %d,  %f,  %f}'; 
        node_num = j;
        bus_name = Clusters{i,j};
        Line_name = FindLineFunction(bus_name,Lines,SequencePrimary,SOURCEBUS);
        Line_name=strrep(Line_name,'"','');
        if strcmp(bus_name,SOURCEBUS)
            t_num = 1;
        else
            t_num = 2;
        end
        kv_base = 7.2;
        kcq = 1;
        [strFmNds,errmsg] = sprintf(str,clusterNum, node_num,bus_name,Line_name,t_num,kv_base,kcq);
        fprintf(fid_fm,'%6s\n',strFmNds);
        if j==Nodes
            fprintf(fid_fm,'%6s\n',"  "); 
        end
    end
    %fclose(fid_fm);


%% comm matrix
str = 'Fmonitor.FM%d.CommVector={'; % FM_cluster, Node
    [strFmCm0,errmsg] = sprintf(str, clusterNum);
    for j = 1:Nodes
        str = strFmCm0;
            strFmCm = strcat(str,num2str(j));
            for ji = 1:Nodes
                str = strFmCm;
                strFmCm = strcat(str,',1');
            end
            str = strFmCm;
            strFmCm = strcat(str,'}');
            % write this line into file
            fprintf(fid_fm,'%6s\n',strFmCm);
        if j==Nodes
            fprintf(fid_fm,'%6s\n',"  "); 
        end
    end
    
end
fclose(fid_fm);
    
    