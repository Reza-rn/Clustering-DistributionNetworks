function ConFinal=ModifyConnection(Connection,SourceBus)

%%
%Connection matrix dimension
Dim=size{Connection};
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
  LineMax=RowSizeFunction(Layer,Line);
  if Line>2
      LineMaxPrevious=RowSizeFunction(Layer,Line-1);
  end
  Line=Line+1;
  stop=1;
  j=1;
  for k=1:LineMax
      i=1;
      while 1
          if Line==2
            if strcmp(Connection{i,1},Layer{Line-1,k})     
                Layer{Line,j}=Connection{i,2};
                j=j+1;
                ConFinal{x,1}=Layer{Line-1,k};
                ConFinal{x,2}=Connection{i,2};
                x=x+1;
                stop=0;
            elseif strcmp(Connection{i,2},Layer{Line-1,k})
                Layer{Line,j}=Connection{i,1};
                j=j+1;
                ConFinal{x,1}=Layer{Line-1,k};
                ConFinal{x,2}=Connection{i,1};
                x=x+1;
                stop=0;
            end
          else
              if strcmp(Connection{i,1},Layer{Line-1,k})
                  Repeat=0;
                  for o=1:LineMaxPrevious
                      if strcmp(Connection{i,1},Layer{Line-2,o})
                          Repeat=1;
                      end
                  end
                  if Repeat==0
                      Layer{Line,j}=Connection{i,2};
                      j=j+1;
                      ConFinal{x,1}=Layer{Line-1,k};
                      ConFinal{x,2}=Connection{i,2};
                      x=x+1;
                      stop=0;
                  end
              elseif strcmp(Connection{i,2},Layer{Line-1,k})
                  Repeat=0;
                  for o=1:LineMaxPrevious
                      if strcmp(Connection{i,2},Layer{Line-2,o})
                          Repeat=1;
                      end
                  end
                  if Repeat==0
                      Layer{Line,j}=Connection{i,1};
                      j=j+1;
                      ConFinal{x,1}=Layer{Line-1,k};
                      ConFinal{x,2}=Connection{i,1};
                      x=x+1;
                      stop=0;
                  end
              end
              
          end
            i=i+1;
            if i>Dim
                break;
            end         
              
      end
          
  end
  if stop==1
      break;
  end
end
  


end



