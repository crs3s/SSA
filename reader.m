% ѡȡ��������
% ��Դ�ֱ����б��ʵ������

% clrscr @ STARDUST STUDIO 2012.3.6

% ѡ���ļ�
[filename, pathname, filterindex] = uigetfile( {'*.SEC01','������ϱ������ļ�(*.SEC01)';...
    '*.SEC02','��������������ļ�(*.SEC02)';'*.HF01','�ϱ�������Ƶ����(*HF01)';...
    '*.HF02','����������Ƶ����(HF02)';'*.*','�����ļ�(*.*)'}, 'Pick  file', 'MultiSelect', 'on');
% �ж��Ƿ�ѡ�����ļ�
if filterindex ~= 0
    data = [];
    if iscell(filename)
        for i = 1:1:length(filename)
            fullfilename = fullfile(pathname,filename{i});
            repStr(fullfilename,'1e+06');
            repStr(fullfilename,'NULL');
            data = [data,load(fullfilename)];
        end
    else
        fullfilename = fullfile(pathname,filename);
        repStr(fullfilename,'1e+06');
        repStr(fullfilename,'NULL');
        data = load(fullfilename);
    end
    data=data';
    time=0:length(data)-1;
    figure;plot(time,data);xlabel('time');ylabel('ms');
    clear filename;
    clear filterindex;
    clear fullfilename;
    clear i;
    clear pathname;
end