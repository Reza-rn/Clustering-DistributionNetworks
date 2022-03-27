%This code is used to find a special bus in the connection cells
%index=strcmpi('l2989596',Layers);
%index=strcmpi('181901',Sequence);
%Dim=size('s_ncctt4232_bt',connection);
Dim=size(Connection,1);

for i=1:Dim
   if strcmp('s_ncctt4232',Connection{i,1})
       i
   elseif strcmp('s_ncctt4232',Connection{i,2})
       i
   end
end