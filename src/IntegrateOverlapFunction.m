function Clusters=IntegrateOverlapFunction(Clusters,Overlap)

%number of overlap buses
Num=size(Overlap,1);

%%
for i=1:Num
    ColumnNum=RowSizeFunction(Clusters,i);
    Clusters{i,ColumnNum+1}=Overlap{i,1};
end


end
