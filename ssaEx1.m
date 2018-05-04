% ʵ��1

% ssaEx1
% ���޸Ĳ��ִ�������Ӧ��ֵ

%% ��ʼ��
% clear;
% clc;
% tic;

%% ��������
% load station % ̨վ��Ϣ

%% ���ø�������
minla=23; % ��Сγ��
unitla=.1; % γ�򲽳�
maxla=37; % ���γ��
minlg=98; % ��С����
unitlg=.1; % ���򲽳�
maxlg=112; % ��󾭶�

%% ����ʱ�����
startime=0; % һ������ֵ
unitime=5;
endtime=startime+100;

%% �����ٶȽṹ
vel=3; % �����沨�����ٶȣ��ô�Ϊ3Km/s

%% ����Ȩ�ش�
% weigwin=ones(1,60);

%% �������
% stationData=ssaPrep(startime,endtime,weigwin); % ����̨վ����
stationData=sig;
stationData=[stationData,zeros(9,1000)];
numStatD=size(stationData,1); % ��ȡ̨վ��
[gridlg,gridla]=meshgrid(minlg:unitlg:maxlg,minla:unitla:maxla); % ���ɸ���
[m,n]=size(gridlg);

wb=waitbar(0,'��ȴ�...','Name','���ڼ������Ⱥ���ͼ');
multiGrid=[];
for time=startime:unitime:endtime
    gridli=zeros(m,n);
    for i=1:1:m
        for j=1:1:n;
            tsum=0;
            for k=1:1:numStatD
%                 ind=scfind(station,stationData{k,1}); % ����̨վ������Ե�̨վ�������ݵ�λ��
                tsf=delti(dist(station{k,2},station{k,3},gridla(i,j),gridlg(i,j)),vel);
                tsf=round(tsf);
                unit=stationData(k,time-startime+tsf+1); % ʹ��NS������
                tsum=tsum+unit;
            end
            gridli(i,j)=1/numStatD*tsum;
        end
    end
    multiGrid=cat(3,multiGrid,gridli);
    waitbar((time-startime)/(endtime-startime));
    figure;imagesc(gridlg(1,:),gridla(:,1)',gridli);axis xy;colorbar;...
        caxis([0,1]);title(num2str(time)); % ��ʾstattime����ͼ
end
close(wb);
% toc;