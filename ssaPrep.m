function [stationData]=ssaPrep(startime,endtime,weigwin)
% SSA����Ԥ����
% ѡ�񵥸�����̨վ�ļ���������Ӧʱ���ڵı�׼station.mat����
% Ԥ�������ݰ�����1�������2ȥ�����ƣ�3��ʱ�䴰�����4��ϳ�cell
% �����sepaMtx.m�ļ���repNULL.m�ļ�

% clrscr @ STARDUST STUDIO

% ѡ���ļ�
[filename, pathname, filterindex] = uigetfile( ...
    {'*.SEC','����������ļ�(*.SEC)';...
%     '*.TSF','gPhone��������(*.TSF)'...
    '*.*','�����ļ�(*.*)'},...
    'Pick  file', 'MultiSelect', 'on');
stationData=[];
% �ж��Ƿ�ѡ�����ļ�
if filterindex >= 1
    if iscell(filename) % ���ѡ�����ļ�
        wb=waitbar(0,'��ȴ�...','Name','���ڶ�ȡ����...');
        for i = 1:1:size(filename,2)
            ff=fullfile(pathname,filename{i});
            stationData=[stationData;extractData(ff,startime,endtime,weigwin)];
            waitbar(i/size(filename,2));
        end
    else % ��ѡ��һ���ļ�
        msgbox('ѡ���ļ���Ŀ������','����');
    end
    close(wb);
else
    stationData=NaN;
end

end