function check=CheckConnection(Connection)

status=1;
Bus1{1,1}=0;
%----------------------------------------------------
%Number of lines
LineNum=size(Connection);
LineNum=LineNum(1,1);
%----------------------------------------------------
%check second column for non-repetitive buses---
i=0;
k=1;
while 1
    i=i+1;
    if i>LineNum 
        break;
    end
    for j=1:LineNum
       if j ~= i
          if strcmp(Connection{j,2},Connection{i,2})
             status=0;
             Bus1{k,1}=Connection{i,2};
             k=k+1;
          end
       end
    end
    
    
end
%Check comparing first and second column-----


%Final message---------------------------------------
if status==1
    check1='Ok';
elseif status==0
    check1='Defective';
end
%----------------------
check={check1,Bus1}


end