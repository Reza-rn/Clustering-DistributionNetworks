function Layer = LayerFunction(Connection,LineNum,SourceBus)

Layer{1,1}=SourceBus;
 m=1;
 Line=2;
 while 1
    LayerElemNum=0;
    k=1;
    for i=1:m
        for j=1:LineNum
           if strcmp(Connection{j,1},Layer{Line-1,i}) 
               Layer{Line,k}=Connection{j,2};
               LayerElemNum=LayerElemNum+1;
               k=k+1;
           end
        end
    end
    Line=Line+1;
    m=LayerElemNum;
    if LayerElemNum==0
        break;
    end
    
 end
 
end