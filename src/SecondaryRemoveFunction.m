function Connection=SecondaryRemoveFunction(Connection)


i=1;
while 1
   A=Connection{i,1};
   B=Connection{i,2};
   X1=A(1);
   X2=B(1);
   Y1=A(1:2);
   Y2=B(1:2);
   
   if (X1=='X')|(X2=='X')
       Connection=RemoveLineFunction(Connection,i);
       i=i-1;
   elseif (Y1=='SX')|(Y2=='SX')
       Connection=RemoveLineFunction(Connection,i);
       i=i-1;
   end

    i=i+1;
    Dim=size(Connection);
    Dim=Dim(1,1);
    if i>Dim
        break;
    end
    
end




end