% 时间开销图
x=[1 2 3 4 5];
y1=[2.29 0 0.73 68.13 1.88];
y2=[0.42 0 0.3 44.28 0.93];

y=[y1;y2]';
b = bar(x,y);
for i = 1:5
text(x(i)-0.3,y(i,1)+3,num2str(y(i,1)));
end

for i = 1:5
text(x(i)+0.03,y(i,2)+3,num2str(y(i,2)));
end

b(1).FaceColor = [0.6 0.6 0.6];
b(2).FaceColor = [0.9 0.9 0.9];
ylabel('Time Consumption/s');
legend('iPhone 6s','MI 3');
set(gca,'xticklabel',{'SMO','k-NN','C4.5','LMT','RandomForest'});