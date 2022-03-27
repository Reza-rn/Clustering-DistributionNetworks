
function Connection=RemoveSameLinesFunction(Connection)

i=1;
while 1
    
    if strcmp(Connection{i,1},Connection{i,2})
        Connection=RemoveLineFunction(Connection,i);
        i=i-1;
    else
      
        j=i+1;
        while 1
            if strcmp(Connection{i,1},Connection{j,1})&(strcmp(Connection{i,2},Connection{j,2}))
                Connection=RemoveLineFunction(Connection,j); 
                j=j-1;
            elseif strcmp(Connection{i,1},Connection{j,2})&(strcmp(Connection{i,2},Connection{j,1}))
                Connection=RemoveLineFunction(Connection,j);
                j=j-1;
            end
            j=j+1;
            Dim2=size(Connection);
            Dim2=Dim2(1,1);
            if j>Dim2
                break;
            end

        end

    end

    i=i+1;
    Dim1=size(Connection);
    Dim1=Dim1(1,1);
    if i>=Dim1
        break;
    end
end












end