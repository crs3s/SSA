% ��ȡ��������
% ���TSF��ʽ����������

% clrscr @ STARDUST STUDIO 2012.3.6

% ѡ���ļ�
[filename, pathname, filterindex] = uigetfile( {'*.TSF','gPhone��������(*.TSF)';...
    '*.*','�����ļ�(*.*)'}, 'Pick  file', 'MultiSelect', 'on');
if filterindex ~= 0
    gdata = [];
    if iscell(filename)
        for i = 1:1:length(filename)
            fullfilename = fullfile(pathname,filename{i});
            %             data = [data,load(fullfilename)];
            gravData=importdata(fullfilename,' ',11);
            gdata=[gdata;gravData.data(:,7)];
        end
    else
        fullfilename = fullfile(pathname,filename);
        gravData=importdata(fullfilename,' ',11);
        gdata=gravData.data(:,7);
    end
%     data=data';
    time=0:length(gdata)-1;
    figure;plot(time,gdata);xlabel('time');ylabel('mGal');
    clear filename;
    clear filterindex;
    clear fullfilename;
    clear i;
    clear pathname;
end