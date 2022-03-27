function RowSize=RowSizeFunction(cell,row)

%This function is used to determine the number of the elements of any cell
%in speciall row of row
MaxDimen=size(cell);
MaxDimen=MaxDimen(1,2);
x=0;
while 1
    x=x+1;
   if isequal(cell{row,x},'' )||(x>=MaxDimen)
       if isequal(cell{row,x},'' )
         x=x-1;
       end
       break;
   end
    
end

RowSize=x;
end