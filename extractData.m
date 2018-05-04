function [ stationData ] = extractData( ff,startime,endtime,weigwin )
%extracData ��ȡ����
% ff �ļ�
% MT ����������󣬴�СΪN*2
% �����repNULL.m�ļ�

% �ж��ļ�����
ind=find(ff=='.',1,'last');
ext=ff(ind+1:end);

if strcmp(ext,'SEC')
    
    
    repStr(ff,'NULL'); % �滻�ļ��е�NULL�ַ�
    repStr(ff,'999999');
    M = load(ff);
    % ���M����Ϊ����������
    if mod(length(M),2) == 1
        M = [M,0];
    end
    ffhead=M(1,1:8);
    M(1:8)=[];
    % �������
    MT=reshape(M,2,length(M)/2);
    % �޳�����
    DT=zeros(size(MT(1:2,startime:endtime)));
    for i=1:2
        %         figure;
        data=MT(i,startime:endtime); %ԭʼ����
        %         subplot(411);plot(startime:endtime,data);title('ԭʼ����');
        %         1 С���ֽ�
        data=data-mean(data);
%                 hfdata=data; % ֱ�����
        [c,l]=wavedec(data,6,'db4');
        %         %         ��ȡ��Ƶ���ݷ���1����ȡ���ƣ��޳����Ƶõ���Ƶ����
        %         c(l(1)+1:end)=0;
        %         rbdata=waverec(c,l,'db4');
        %         hfdata=data-rbdata; % ȥ������
        %         %         ��ȡ��Ƶ���ݷ���1******************************
        % ��ȡ��Ƶ���ݷ���2�����ø�Ƶϵ���ؽ��ź�
        c(1:l(1))=0;
        hfdata=waverec(c,l,'db4');
%         subplot(412);plot(startime:endtime,hfdata);title('��Ƶ����');
        % ��ȡ��Ƶ���ݷ���2******************************
        % 2 �˲�
%                 [b,a]=butter(4,[0.36,0.5]);
%                 hfdata=filter(b,a,data);
        %         subplot(412);plot(startime:endtime,hfdata);title('�˲�������');
        %         % �˲�******************************************
        hfdata=abs(hfdata); % ����ֵ
        %         hfdata=uniti(hfdata); % ��λ������
        %         subplot(413);plot(startime:endtime,hfdata);title('��һ������');
        hfdata=conv(hfdata,weigwin,'same')/sum(weigwin,2); % ��Ȩ�ش����о��
        hfdata=uniti(hfdata); % ��λ��
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %1
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %2
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %3
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %4
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %5
        %         hfdata=envelope(1:size(hfdata,2),hfdata); %6
        %         hfdata(isnan(hfdata))=0;
        %         subplot(414);plot(startime:endtime,hfdata);title('Ȩ�ؾ������');
        DT(i,:)=hfdata;
        %         xlabel([num2str(ffhead(1,3)),'|',num2str(ffhead(1,6+i))]);
    end
    stationData={ffhead(1,3),ffhead(1,2),{ffhead(1,7),DT(1,:)},...
        {ffhead(1,8),DT(2,:)}};
else
    msgbox('�ļ����ͳ������ѯ...','����');
    % elseif strcmp(ext,'TSF')
    %     repStr(ff,'999999');
    %     gravData=importdata(ff,' ',11);
    %     data=gravData.data(startime:endtime,7);
    
end

end