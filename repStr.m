function []=repStr(ff,repStr)
% �滻�ļ��е�repStr�ַ�

fid=fopen(ff);
tl=fgetl(fid);
fclose(fid);
sf=strfind(tl,repStr);
if(~isempty(sf))
    fid=fopen(ff,'w+');
    tl=strrep(tl,repStr,'NaN');
    fprintf(fid,tl);
    fclose(fid);
end

end