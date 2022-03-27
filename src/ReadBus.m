function A = ReadBus

fid=fopen('Lines.dss','r');
%A = fscanf(fid,'Bus1=%d');
%fclose(fID);
j=1;
    while 1
        s = fgetl(fid); 
        s = lower(s);
          if ischar(s)
            a=strfind(s,'bus');
            if isequal(a,'' )
            else
                for k=1:2
                    i=0;
                    while 1
                        x=s(a(k)+i);
                        if x=='.'||strcmpi(x,' ')
                            break
                        end
                        i=i+1;
                    end
                    A{j,k}=s(a(k)+5:a(k)+i-1);
                end
                j=j+1;
            end
          else  % End of file:
            break;
          end
         
    end
    
  %%
  %Wieght of each line
  x=size(A);
  x=x(1,1);
  for i=1:x
     A{i,3}=1; 
  end
  
  

end