x=[0 1 2 3];
y=[7 13 16 4];
b = bar(x,y);
str = {'7, 17.5%';'13, 32.5%';'16, 40%';'4, 10%'};
ylim([0 18]);

text(x(1)-0.2,y(1)+0.5, str(1));
text(x(2)-0.25,y(2)+0.5, str(2));
text(x(3)-0.2,y(3)+0.5, str(3));
text(x(4)-0.15,y(4)+0.5, str(4));

b.FaceColor = [0.6 0.6 0.6];
ylabel('Arributes');
xlabel('Sensor');
set(gca,'xticklabel',{'加速度','加速度(去重力)','陀螺仪','方向'});