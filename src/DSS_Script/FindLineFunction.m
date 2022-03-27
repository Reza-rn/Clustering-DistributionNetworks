function LineName=FindLineFunction(bus,Lines,Sequence,SOURCEBUS)

%This function is used to determine the number of the elements of any cell
%in speciall row of row
%MaxDimen = size(SequencePrimary,1);

%%
%find ancestor
x=0;
while 1
   x=x+1;
   if strcmp(bus,SOURCEBUS)
       parent=SOURCEBUS;
       disp('Sourcebus');
       break;
   end
   if strcmp(bus,Sequence{x,1})
       parent=Sequence{x,2};
       break;
   end
end

%%
%find line
x=0;
Dim=size(Lines,1);
while 1
   x=x+1;
   if x>Dim
       disp(bus);disp(parent);
   end
   %change bus names in Lines to uppercase
   %Bus1=upper(Lines{x,1});
   %Bus2=upper(Lines{x,2});
   Bus1=Lines{x,1};
   Bus2=Lines{x,2};
   if strcmp(bus,Bus1)&strcmp(parent,Bus2)
       LineName=Lines{x,3};
       break;
   elseif strcmp(bus,Bus2)&strcmp(parent,Bus1)
       LineName=Lines{x,3};
       break;
   elseif strcmp(bus,SOURCEBUS)
      LineName=Lines{x,3};
      break;
   end    
end


end