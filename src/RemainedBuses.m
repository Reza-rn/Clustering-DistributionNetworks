%This function is used to find the unselected lines which is not selected
%during clustering (Not conncted to the root bus)

function Remained=RemainedBuses(SelectedLines,Lines)

NumSelectedLines=size(SelectedLines,1);
NumLines=size(Lines,1);

for i=1:NumSelectedLines
    
    j=1;
    while 1
        if (strcmp(SelectedLines{i,1},Lines{j,1}))&(strcmp(SelectedLines{i,2},Lines{j,2}))
            Lines = RemoveLineFunction(Lines,j);
            NumLines = NumLines -1; 
            break;
        elseif (strcmp(SelectedLines{i,1},Lines{j,2}))&(strcmp(SelectedLines{i,2},Lines{j,1}))
            Lines = RemoveLineFunction(Lines,j);
            NumLines = NumLines -1; 
            break;
        end
        
        j=j+1;
        if j>NumLines
            break;
        end
    end
end


Remained=Lines;

end

