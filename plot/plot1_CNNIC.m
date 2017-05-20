 x = [datetime(2012,6,1) datetime(2012,12,1) datetime(2013,6,1) ...
     datetime(2013,12,1) datetime(2014,6,1) datetime(2014,12,1) ...
     datetime(2015,6,1) datetime(2015,12,1) datetime(2016,6,1) datetime(2016,12,1)];
 y1 = [3.88 4.20 4.64 5.00 5.27 5.57 5.94 6.20 6.56 6.95];
 y2 = [72.1 74.5 78.5 81.0 83.4 85.8 88.9 90.1 92.5 95.1];

yyaxis left
bar(x,y1,'DisplayName','y1','FaceColor',[0.9 0.9 0.9])
ylabel('手机网民数量/亿')

yyaxis right
plot(x,y2,'s-','LineWidth',2)
ylabel('手机网民比例/%')

