%==================================================
%=      1979���й�������Ч������ƽ��ֵ�ֲ����                         
%==================================================

clear,clc;

%��ȡ����
swh = ncread("1979.nc",'swh');
lat = ncread("1979.nc",'latitude');
lon = ncread("1979.nc",'longitude');

%����Ч������ƽ��ֵ
swh_avg_year = nanmean(swh,3);

%�ҵ����γ�ȶ�Ӧ������
lat_min = find(lat==50);%��С�����,����,50��N,1
lat_max = find(lat==10);%10,321
lon_min = find(lon==105);%��С����С������,105,121
lon_max = find(lon==135);%135,361

%ȷ����Χ
lon = lon(lon_min:lon_max);
lat = lat(lat_min:lat_max);

[X, Y] = meshgrid(lon,lat);
swh_avg_year_china_nearshore = swh_avg_year(lon_min:lon_max,...
                                            lat_min:lat_max);

%��ͼ
figure
m_proj('lambert','long',[105 135],'lat',[5 44]);
m_coast('patch',[.7 .7 .7],'edgecolor','b');
m_grid('linest','none','box','fancy','tickdir','in');
xlabel('longitude');
ylabel('latitude');
title({'significant wave height(m)','1979'});
colorbar
hold on
m_pcolor(X,Y,swh_avg_year_china_nearshore');

%����
saveas(gcf,"1979_year_avg.png");