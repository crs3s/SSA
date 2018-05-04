% SSA ��Դ�����㷨

% clrscr @ STARDUST STUDIO 2012.2

%% ��ʼ��
clear;
clc;
tic;

%% ��������
% load station % ̨վ��Ϣ
stationInp; % ����̨վ��Ϣ

%% ���ø�������

minLa=20; % ��Сγ��
unitLa=0.5; % γ�򲽳�
maxLa=50; % ���γ��
minLg=100; % ��С����
unitLg=0.5; % ���򲽳�
maxLg=130; % ��󾭶�

%% ����ʱ�����

startTime=33600  ; % һ������ֵ
uniTime=60;
endTime=startTime+1200*2;
% endTime=3600*6;
dataEndTime=0; % Ĭ��Ϊ0����0��ʹ���޸�ֵ�����򣬼������ʱ


%% �����ٶȽṹ
velT=2.8; % �����沨�����ٶȣ��ô�Ϊ3Km/s
velG=2.9;

%% ����ʱ�䴰
% weigWin=ones(1,10); %  ƽ���ֲ�
weigWin=normpdf(1:20,10,7); % ��̬�ֲ�
% weigWin=1;
% % ����ʱ�䴰
% figure;plot(weigWin);title('ʱ�䴰');

%% �������
% �������ʱ
badTsf=ceil(delti(dist(minLa,minLg,maxLa,maxLg),min(velT,velG)));
if dataEndTime==0
    dataEndTime=endTime+badTsf;
end
stationData=ssaPrep(startTime,dataEndTime,weigWin); % ����̨վ����
% close all;

% δ��ȡ����������������
if iscell(stationData)==0
    break;
end

% % ���Ƹ�̨վ�������
sizeStatData=size(stationData,1);
% for nw=3:4
%     figure;
%     for i=1:sizeStatData
%         subplot(sizeStatData,1,i);
%         plot(stationData{i,nw}{1,2});
%         title([num2str(stationData{i,1}),'|',num2str(stationData{i,nw}{1,1})]);
%     end
% end

% numStatD=size(stationData,1); % ��ȡ̨վ��
% [gridLg,gridLa]=meshgrid(minLg:unitLg:maxLg,minLa:unitLa:maxLa); % ���ɸ���
% [m,n]=size(gridLg);
% 
% wb=waitbar(0,'��ȴ�...','Name','���ڼ������Ⱥ���ͼ');
% multiGrid=[];
% timeAndMax=[];
% for time=startTime:uniTime:endTime
%     gridOneLay=zeros(m,n);
%     for i=1:1:m
%         for j=1:1:n;
%             tsum=0;
%             for k=1:1:numStatD
%                 ind=scfind(station,stationData{k,1}); % ����̨վ������Ե�̨վ�������ݵ�λ��
%                 if ind==-1
%                     msgbox('δ�ҵ���Ӧ̨վ��','����');
%                     break;
%                 end
%                 if strcmp(station{ind,6},'tilt')
%                     vel=velT;
%                 elseif strcmp(station{ind,6},'gravity')
%                     vel=velG;
%                 end
%                 tsf=delti(dist(station{ind,4},station{ind,3},gridLa(i,j),gridLg(i,j)),vel);
%                 tsf=round(tsf);
%                 % ���ݳ��ޣ�ֵΪ0
%                 if time+tsf >= dataEndTime || tsf==0
%                     unit=0;
%                 else
%                     unit=stationData{k,3}{1,2}(time-startTime+tsf); % ��ȡstationData����Ӧ����
%                 end
%                 tsum=tsum+unit;
%             end
%             gridOneLay(i,j)=1/numStatD*tsum;
%         end
%     end
%     waitbar((time-startTime)/(endTime-startTime));
%     % ����ֵȫΪ0��������һ��ѭ��
%     if gridOneLay==zeros(m,n)
%         continue;
%     end
%     % ��������ͼ2-1****************************************
%     figure;imagesc(gridLg(1,:),gridLa(:,1)',gridOneLay);axis xy;colorbar;...
%         caxis([0,1]);
%     hold on;
%     % ����̨վλ��
%     for i=1:sizeStatData
%         indStat=scfind(station,stationData{i,1});
%         plot(station{indStat,3},station{indStat,4},'ws');
%     end
%     % ��������ͼ2-1****************************************
%     
%     % ͻ����ʾ���ֵ����λ��
%     maxGridOneLay=max(max(gridOneLay));
%     [indMaxLg,indMaxLa]=find(gridOneLay==maxGridOneLay);
%     maxLg=gridLg(indMaxLg,indMaxLa);
%     maxLa=gridLa(indMaxLg,indMaxLa);
%     if length(maxLg)>1
%         maxLg=maxLg(1);
%         maxLa=maxLa(1);
%         indMaxLg=indMaxLg(1);
%         indMaxLa=indMaxLa(1);
%     end
%     
%     % ��������ͼ2-2****************************************
%     plot(maxLg,maxLa,'wo');
%     
%     % ��ʾʱ������ֵ
%     title([sec2time(time),'(',num2str(time),')',' ','|',' ',num2str(maxGridOneLay),...
%         '(',num2str(maxLg),',',num2str(maxLa),')']);
%     hold off;
%     % ��������ͼ2-2****************************************
%     
%     % ��¼��ǰʱ��������ֵ
%     timeAndMax=[timeAndMax;[time,maxGridOneLay,maxLg,maxLa,indMaxLg,indMaxLa]];
%     % ��¼��ʷ���Ⱥ���ֵ
%     multiGrid=cat(3,multiGrid,gridOneLay);
% end
% close(wb);
% 
% % ���������ֵ�仯ͼ
% figure;plot(timeAndMax(:,1),timeAndMax(:,2),'--b*');xlabel('time/s');ylabel('lightness');title('������Ⱥ���ֵ�仯ͼ');
% hold on;
% maxLight=max(timeAndMax(:,2));
% [c,r]=find(timeAndMax==maxLight);
% xlim=get(gca,'XLim');plot(xlim,0.85*ones(1,2),'-m');
% title([sec2time(timeAndMax(c,1)),'(',num2str(timeAndMax(c,1)),')','|',...
%     num2str(timeAndMax(c,2)),'(',num2str(timeAndMax(c,3)),...
%     ',',num2str(timeAndMax(c,4)),')']);
% hold off;
% 
% % �������Դλ�����Ⱥ���ֵ�仯ͼ
% figure;
% allMaxLg=timeAndMax(c,5);
% allMaxLa=timeAndMax(c,6);
% lightness(1:size(multiGrid,3))=multiGrid(allMaxLg,allMaxLa,:);
% plot(timeAndMax(:,1),lightness);hold on;
% set(gca,'Ylim',[0,1])
% xlim=get(gca,'Xlim');plot(xlim,0.85*ones(1,2),'--m');
% xlabel('time/s');ylabel('lightness');title('���Դ����ֵ�仯ͼ')
% hold off;
% 
% % �������Դ��λ���ͼ
% % ��������ͼ
% soureLay(1:m,1:n)=multiGrid(:,:,c);
% figure;imagesc(gridLg(1,:),gridLa(:,1)',soureLay);axis xy;colorbar;...
%     caxis([0,1]);
% hold on;
% % ����̨վλ��
% for i=1:sizeStatData
%     indStat=scfind(station,stationData{i,1});
%     plot(station{indStat,3},station{indStat,4},'ws');
% end
% % ͻ����ʾ���ֵ����λ��
% plot(timeAndMax(c,3),timeAndMax(c,4),'wo');
% % ��ʾʱ������ֵ
% title([sec2time(timeAndMax(c,1)),'(',num2str(timeAndMax(c,1)),')',' ','|',' ',num2str(timeAndMax(c,2)),...
%     '(',num2str(timeAndMax(c,3)),',',num2str(timeAndMax(c,4)),')']);
% hold off;

toc;