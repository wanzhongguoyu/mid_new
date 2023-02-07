function [Mt] = fNIRT(mark,LPT,id)
%V1.1 a
%update:V1.0 to V1.1
%update: now the output can get both mark and time!
%Mt = [Mark,Timepoint]
%check if the 'inpoutx64.dll' in the true file? then start!
%We need the support of PTB3(Getsecs)
%mark is the alue of the mark.
%LPT is 3 usually.
%it's the I/O of  FNIR and send signT to fNIRs' computer.
%By Xynico Jiang
if mark>255
    disp('Error(00) in Mark point,the value of the mark is too much to input,you need to set a mark below 255( "mark<255" )');
end
if LPT == 1
    LPT = '378';
elseif LPT == 2
    LPT = '278';
elseif LPT == 3
    LPT = 'C100';
else
    disp('Error(00) in LPT,the LPT is error!');
end
object = io64;
status = io64(object);
if status == 0
    address = hex2dec(LPT);
    data_out = mark;
    io64(object,address,data_out);
    data_in = io64(object,address);
    TimePoint = GetSecs;
    Mark = mark;
    SubjID = id;
%     if isnumeric(mark)
%         pathname = cd;
%         filename = [num2str(id),'marker.nrx'];
%         Trigger_control(mark,pathname,filename);
%     end
else
    disp('Error(01) in Status Connect,check the I/O and run it again.If it still has wrong,you can ask Baidu to solve it!:)');
end
    io64(object,address,0);
clear io64

Mt = table(SubjID,Mark,TimePoint);
% Mt=table(mark,LPT,id);
end
