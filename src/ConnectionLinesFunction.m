function ConnetionLines = ConnectionLinesFunction(FileName)

%%
fid=fopen(FileName,'r');
%A = fscanf(fid,'Bus1=%d');
%fclose(fID);

%%
%cycle to find buses
j=1;
    while 1
        s = fgetl(fid);
        new_s = lower(s);
          if ischar(s)
           if strlength(s) ~= 0
            if s(1) == '!'
               s = '';
               new_s = '';
            end
            % Find disabled switches
            OffSwitch1 = strfind(new_s,'enabled=n');
            OffSwitch2 = strfind(new_s,'enabled=f');
            if (isequal(OffSwitch1,''))&(isequal(OffSwitch2,''))
            else
                s = '';
               new_s = '';
            end
            % Find Fuses
            Fuse = strfind(new_s,'fuse.fuse');
            if isequal(Fuse,'')
            else
                s = '';
               new_s = '';
            end
            % End Find Fuses
           end
            a=strfind(new_s,'bus');
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
%cycle to find lines or...
fid=fopen(FileName,'r');
j=1;
 while 1
    s = fgetl(fid);
    new_s = lower(s);
    if ischar(s)
        if strlength(s) ~= 0
           if s(1) == '!'
               s = '';
               new_s = '';
           end
           % Find disabled switches
            OffSwitch1 = strfind(new_s,'enabled=n');
            OffSwitch2 = strfind(new_s,'enabled=f');
            if (isequal(OffSwitch1,''))&(isequal(OffSwitch2,''))
            else
                s = '';
               new_s = '';
            end
           % Find Fuses
            Fuse = strfind(new_s,'fuse.fuse');
            if isequal(Fuse,'')
            else
                s = '';
               new_s = '';
            end
            % End Find Fuses
         end
       %a=strfind(s,'New');
       a=5;
       if isequal(s,'' )
       else
         i=0;
         while 1
            x=s(a+i);
            if strcmpi(x,' ')   %x=='.'||strcmpi(x,' ')
                break;
            end
            i=i+1;
         end
           A{j,3}=s(a:a+i-1);
           j=j+1;
       end
    else  % End of file:
       break;         
    end
 end
fclose(fid);
%%
    
ConnetionLines=A;

end
    