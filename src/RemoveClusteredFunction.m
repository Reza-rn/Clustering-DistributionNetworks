function Connection=RemoveClusteredFunction(Clusters,Connection,New,LineNum)

stop=size(Connection);
stop=stop(1,1);
row=size(Clusters);
row=row(1,1);
remove=0;
p=1;
if stop>=1

   %Find remove lines
    for i=row:-1:row-New+1
        k=RowSizeFunction(Clusters,i);
        for j=1:k
           for m=1:LineNum
               for o=1:2
                 if strcmp(Clusters{i,j},Connection{m,o})
                     remove(p,1)=m;
                     p=p+1;
                 end
               end
           end
        end
    end
    
    %Find same lines and remove them
    r=0;
    s=0;
    Dimension=size(remove);
    Dimension=Dimension(1,1);
    while 1
      r=r+1;
      if r>=Dimension
          break;
      end
      s=r+1;
      while 1
        Dimension=size(remove);
        Dimension=Dimension(1,1);
        if s>Dimension
            break;
        end
        if remove(r,1)==remove(s,1)
            remove(s,:)=[];
            s=s-1;
        end
        s=s+1;
      end
    end
    
    %Ordered the remove lines
    r=0;
    s=0;
    Dimension=size(remove);
    Dimension=Dimension(1,1);
    while 1
      r=r+1;
      if r>=Dimension
          break;
      end
      s=r+1;
      while 1
        if s>Dimension
            break;
        end
        if remove(r,1) > remove(s,1)
           temp1=remove(r,1);
           temp2=remove(s,1);
           remove(r,1)=temp2;
           remove(s,1)=temp1;     
        end
        s=s+1;
      end
    end
    
    %remove the specified lines from connection matrix
    x=size(remove);
    x=x(1,1);
    
    for i=x:-1:1
       Connection(remove(i,1),:)=[];       
    end        
   
end

end