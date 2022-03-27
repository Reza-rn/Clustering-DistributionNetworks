function ismember = ismember_cell(x,Y)

ismember = 0;
Dimension = size(Y,2);

for i=1:Dimension
    if strcmp(x , Y{1,i})
        ismember = 1;
    end
    
end

end