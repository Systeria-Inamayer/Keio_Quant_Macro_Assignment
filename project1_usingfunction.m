clc
clear all
close all


f = fred
startdate = '01/01/1955';
enddate = '01/01/2019';



%Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table" American Economic Review, 105(10), 3150-3182, available for download at www.ggdc.net/pwt
realGDP = fetch(f,'RGDPNAMYA666NRUG',startdate,enddate)      %Real GDP at Constant National Prices for Malaysia   Millions of 2017 Dollars
year = realGDP.Data(:,1);
y_malay = realGDP.Data(:,2);

% load y.mat
% year = linspace(1, 261, 261);



%[cycle, trend] = hpfilter(log(y), 1600);
[cycle_malay, trend_malay] = qmacro_hpfilter(log(y_malay), 1600);

% compute sd(y) (from detrended series)
ysd_malay = std(cycle_malay)*100;





realGDP = fetch(f,'RGDPNAJPA666NRUG',startdate,enddate)      %Real GDP at Constant National Prices for Japan     Millions of 2017 Dollars
year = realGDP.Data(:,1);
y_japan = realGDP.Data(:,2);

% load y.mat
% year = linspace(1, 261, 261);


%[cycle, trend] = hpfilter(log(y), 1600);
[cycle_japan, trend_japan] = qmacro_hpfilter(log(y_japan), 1600);

% compute sd(y) (from detrended series)
ysd_japan = std(cycle_japan)*100;





disp(['Percent standard deviation of detrended log real GDP Malaysia: ', num2str(ysd_malay),'.']); disp(' ')
disp(['Percent standard deviation of detrended log real GDP Japan: ', num2str(ysd_japan),'.']); disp(' ')
cormj = corrcoef(cycle_malay, cycle_japan)
%disp(['Correlation of detrenched log of real GDP Malaysia-Japan: ', num2str(cormj),'.']); disp(' ')



figure
plot(year, cycle_malay,year, cycle_japan)
datetick('x', 'yyyy')
title('Yearly comparison of detrenched log of real GDP Malaysia-Japan')
ylabel('Detrenched log of real GDP')
xlabel('Year')
legend('Malaysia','Japan')
grid on