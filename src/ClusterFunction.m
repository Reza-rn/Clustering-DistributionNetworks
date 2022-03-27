function ClustersNew=ClusterFunction(Clusters,Sequence,X,TotalClusters,Threshold,residual,Overlap)

stopMode=0;
% X= Approximate number of nodes in each clusters
BusNum=size(Sequence);
BusNum=BusNum(1,1);
%-------------------------------------------
%Determine the start point of Cluster matrix
if Clusters{1,1}==0
    start=1;
else
    start=size(Clusters);
    start=start(1,1)+1;
end 
%---------------------------------------------
%check if it is the last cluster
if start==TotalClusters
   stopMode=1;
   n=1;
   
   Dimension=size(Sequence);
   Dimension=Dimension(1,1);
   k=1;
   while 1
       Clusters{start,k}=Sequence{k,1};
       k = k + 1;
       if k>Dimension
           break;
       end
   end
else

  %Normal Clustering procedure------------------
  
  %find leader bus of each cluster
  j=0;
  position=0;
  for i=1:BusNum
     if (Sequence{i,3}<=X+Threshold)&(Sequence{i,3}>=X-Threshold)
      Clusters{start+j,1}=Sequence{i,1};
      j=j+1;
      position(j,1)=i;
     end      
  end
  n=j;  %Number of added clusters
  
  %If the algorithm does not converged, find the out of threshold buses
  if n==0
      j=0;
      disp("Relaxed:");disp(start+n);
      extra=1;
      position=0;
      while 1
          for i=1:BusNum
             if (Sequence{i,3}<=X+Threshold+extra)&(Sequence{i,3}>=X-Threshold-extra)
              Clusters{start+j,1}=Sequence{i,1};
              j=j+1;
              position(j,1)=i;
             end      
          end
          n=j;  %Number of added clusters
          extra=extra+1;
          if n>=1
              break;
          end
      end
  end
  
  %find and remove parent and children buses----------------
  %find
  r=0;
  find=0;
  for i=1:n
     for j=1:Sequence{position(i,1),20}
         for k=1:n
            if strcmp(Sequence{position(i,1),j+3},Clusters{start-1+k,1})
                find=1;
                r=r+1;
                
                %decide to choose whether children or parent
                if abs(residual+(Sequence{position(k,1),3}-X))<=abs(residual+(Sequence{position(i,1),3}-X))
                    Remove(r,1)=start-1+k;
                    residual=residual+(Sequence{position(k,1),3}-X);
                else
                    Remove(r,1)=start-1+i;
                    residual=residual+(Sequence{position(i,1),3}-X);
                end
                %----------------------
            end
        end
     end
     if find==0
        residual=residual+(Sequence{position(i,1),3}-X); 
     end
  end
  
  %Remove
  n=n-r;
  if r>0
      k=1;
      while 1
          
          Clusters(Remove(k,1),:)=[];
          position(Remove(k,1)-start+1,:)=[];
          r=r-1;
          if r==0
              break;
          end
          k=k+1;
          Remove(k,1)=Remove(k,1)-(k-1);

      end
  end
  
  %Find parent of the leader bus as the overlap bus
  for i=1:n
    Overlap{i+start-1,1}=Sequence{position(i,1),2};
  end
  %Find other nodes of the cluster in lower layers of the leader
  j=0;
  k=0;
  for i=1:n
    k=0;    
    while 1  
      stop=1;
      k=k+1;
      if k>RowSizeFunction(Clusters,start+i-1)
          break;
      end        
      if isequal(Clusters{start+i-1,k},'' )
      else
          if k==1    
             j=RowSizeFunction(Clusters,start-1+i);
             for p=1:Sequence{position(i,1),20}
                 j=j+1;
                 Clusters{start-1+i,j}=Sequence{position(i,1),p+3}; 
             end
          else
             for m=1:size(Sequence,1) %m=position(i,1):-1:1     
                if strcmp(Clusters{start+i-1,k},Sequence{m,1})
                   j=RowSizeFunction(Clusters,start-1+i);
                   for p=1:Sequence{m,20}
                      j=j+1;
                      Clusters{start-1+i,j}=Sequence{m,p+3}; 
                   end        
                end               
              end
          end
        end  
    end      
  end    
    
end

ClustersNew={Clusters,n,stopMode,residual,Overlap};

end