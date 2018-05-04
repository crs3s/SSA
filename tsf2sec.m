% tsf2sec
% ת��TSF��ʽ��SEC��ʽ

clear;
% ѡ���ļ�
[filename, pathname, filterindex] = uigetfile(...
    {'*.TSF','gPhone��������(*.TSF)';...
    '*.*','�����ļ�(*.*)'},...
    'Pick  file', 'MultiSelect', 'on');
% �ж��Ƿ�ѡ�����ļ�
if filterindex >= 1
    if iscell(filename) % ���ѡ�����ļ�
        allData=zeros(2,86400*2); % ת�������������޸�
        [b,a]=butter(6,[0.36,0.7]);
        for i = 1:1:size(filename,2)
            ff=fullfile(pathname,filename{i});
            stationCode=ff(find(ff=='(',1,'first')+1:find(ff==')',1,'first')-1);
            date=ff(find(ff=='_',1,'first')+1:find(ff=='.',1,'first')-1);
            if i>1
                if ~(strcmp(stationCode,temStatCode)&&strcmp(date,temDate))
                    msgbox('�����ļ����ڻ�̨վ���������ѯ...','����');
                    break;
                end
            else
                temStatCode=stationCode;
                temDate=date;
            end
            gravData=importdata(ff,' ',11);
            data=gravData.data(:,7);
            if isempty(strfind(ff,'(2121)'))==0
                data=filter(b,a,data);
                allData(1,:)=data;
            else
                allData(2,:)=data;
            end
        end
        % д���ļ�
        head=['0000000',' ',date,' ',stationCode,' ','000XXXXX0000',' ',...
            '02',' ','2',' ','2221',' ','2222'];
        resAllData=reshape(allData,1,size(allData,2)*2);
        newFileName=[stationCode,'222X',date(3:end),'G.SEC'];
        fid=fopen(fullfile(pathname,newFileName),'w');
        fprintf(fid,'%s ',head);
        fprintf(fid,'%.2f ',resAllData);
        fclose(fid);
    else % ��ѡ��һ���ļ�
        msgbox('ѡ���ļ���Ŀ������','����');
    end
end