% plotMap
% ����һ����Χ�ڵ�ͼ

figure;
m_proj('mercator','longtitudes',[80,160],'latitudes',[-10,60]);
m_coast('patch',[.7,.7,.7],'edgecolor','none');
% m_coast('color','k');
m_grid('box','fancy');