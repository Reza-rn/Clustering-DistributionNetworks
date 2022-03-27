function Return = ModifyConnectionFunction2(Connection, SourceBus)

%%
%Connection matrix dimension
Dim=size(Connection);
Dim=Dim(1,1);

%-------------------------------------------
%initial value of the ConFinal matrix
ConFinal{1,1}=0;
%%
%make layers
Layer{1,1}=SourceBus;
Line=1; %Layer function lines
%j=1; %layer funtion columns for each line
x=1;  % ConFinal Line number

i=1;  %connection matrix line number

stop=1;

while 1
  Line=Line+1;
  LineMax=RowSizeFunction(Layer,Line-1);
  if Line>2
      LineMaxPrevious=RowSizeFunction(Layer,Line-2);
  end
  stop=1;
  j=1;
  for k=1:LineMax
      i=1;
      while 1
          if j == 1
            if strcmp(Layer{Line-1,k},Connection{i,1})           
                if (ismember_cell(Connection{i,2},Layer(Line-1,:)))
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    stop = 0;
                else
                    Layer{Line,j}=Connection{i,2};
                    j=j+1;
                    ConFinal{x,1}=Layer{Line-1,k};
                    ConFinal{x,2}=Connection{i,2};
                    ConFinal{x,3}=Connection{i,3};
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    x=x+1;
                    stop=0;
                end      
           elseif strcmp(Layer{Line-1,k},Connection{i,2})
               if (ismember_cell(Connection{i,1},Layer(Line-1,:)))
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    stop = 0;
               else
                    Layer{Line,j}=Connection{i,1};
                    j=j+1;
                    ConFinal{x,1}=Layer{Line-1,k};
                    ConFinal{x,2}=Connection{i,1};
                    ConFinal{x,3}=Connection{i,3};
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    x=x+1;
                    stop=0;
               end
            end
          % The other elements of row of Line of Layer
          else
              if strcmp(Layer{Line-1,k},Connection{i,1})           
                if ((ismember_cell(Connection{i,2},Layer(Line,:))) | (ismember_cell(Connection{i,2},Layer(Line-1,:))))
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    stop = 0;
                else
                    Layer{Line,j}=Connection{i,2};
                    j=j+1;
                    ConFinal{x,1}=Layer{Line-1,k};
                    ConFinal{x,2}=Connection{i,2};
                    ConFinal{x,3}=Connection{i,3};
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    x=x+1;
                    stop=0;
                end      
           elseif strcmp(Layer{Line-1,k},Connection{i,2})
               if ((ismember_cell(Connection{i,1},Layer(Line,:))) | (ismember_cell(Connection{i,1},Layer(Line-1,:))))
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    stop = 0;
               else
                    Layer{Line,j}=Connection{i,1};
                    j=j+1;
                    ConFinal{x,1}=Layer{Line-1,k};
                    ConFinal{x,2}=Connection{i,1};
                    ConFinal{x,3}=Connection{i,3};
                    Connection=RemoveLineFunction(Connection,i);
                    i = i - 1;
                    Dim = Dim - 1;
                    x=x+1;
                    stop=0;
               end
              end             
              
          end
        i=i+1;
        if Dim == 0
            stop = 1;
        end
        if i>Dim
           break;
        end 
        
      end
      if Dim==0
          break;
      end
  end
  if stop==1
      break;
  end
end
  

Return = {ConFinal,Layer};
end


