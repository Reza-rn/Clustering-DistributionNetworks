
clc
index=strcmpi('l2989596',Layers);
%index=strcmpi('181901',Sequence);
%index=strcmpi('181901',Clusters);

for i=1:size(index,1)
   for j=1:size(index,2)
      
       if index(i,j)==1
           disp(i);
           disp(j);
       end
       
   end
end