function Sequence = SequenceFunction(Connection,Layers,LayersNum,LineNum)

Children_Number_row=20;
%---------------------
%First apply last layer elements for Sequence matrix
k=1;
Dimension=RowSizeFunction(Layers,LayersNum);
while 1
   Sequence{k,1}=Layers{LayersNum,k};
   for i=1:LineNum
      if strcmp(Connection{i,2},Sequence{k,1})
          Sequence{k,2}=Connection{i,1};
          Sequence{k,3}=0;
          Sequence{k,Children_Number_row}=0;
      end
   end
   
   if k==Dimension
       break;
   end
   k=k+1;
   if isequal(Layers{LayersNum,k},'' )
     break;
   end
end

%---------------------------
%Build the rest of sequence matrix
l=size(Layers);l=l(1,2); %Layer matrix column number
j=size(Sequence);
j=j(1,1);
for i=LayersNum-1:-1:1
    k=1;
    j=j+1;
    while 1
        Sequence{j,1}=Layers{i,k};
        %find parent----------
        for m=1:LineNum
            if strcmp(Sequence{j,1},Connection{m,2})
                Sequence{j,2}=Connection{m,1};
            end
        end
        %find children
        child=0;
        weight=0;
        for o=1:LineNum
           if strcmp(Sequence{j,1},Connection{o,1})
               child=child+1;
               weight=weight+Connection{o,3};
                Sequence{j,3+child}=Connection{o,2};
                for p=1:j
                   if strcmp(Sequence{j,3+child},Sequence{p,1})
                      weight=weight+Sequence{p,3}; 
                   end
                end
           end  
        end
        Sequence{j,3}=weight;
        Sequence{j,Children_Number_row}=child;
        
        
        k=k+1;
        if k>l
            break;
        end
       if isequal(Layers{i,k},'' )
           break;
       end
       j=j+1;
    end



end