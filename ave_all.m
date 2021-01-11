%==================================================
%=      1979年中国近海有效波高年平均值分布情况                         
%==================================================

clear,clc;

%读取数据
swh = ncread("1979.nc",'swh');
lat = ncread("1979.nc",'latitude');
lon = ncread("1979.nc",'longitude');

%求有效波高年平均值
swh_avg_year = nanmean(swh,3);

%找到最大经纬度对应的坐标
lat_min = find(lat==50);%最小是最大,坐标,50°N,1
lat_max = find(lat==10);%10,321
lon_min = find(lon==105);%最小是最小，坐标,105,121
lon_max = find(lon==135);%135,361

%确定范围
lon = lon(lon_min:lon_max);
lat = lat(lat_min:lat_max);

[X, Y] = meshgrid(lon,lat);
swh_avg_year_china_nearshore = swh_avg_year(lon_min:lon_max,...
                                            lat_min:lat_max);

%画图
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

%保存
saveas(gcf,"1979_year_avg.png");