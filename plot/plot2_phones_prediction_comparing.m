x=[1 2 3 4 5];
y1=[57.3 23.7 43.6 62.1 58.7];
y2=[52.4 29.8 37.2 54.6 52.2];

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
ylabel('Prediction Accuracy/%');
legend('iPhone 6s','MI 3');
set(gca,'xticklabel',{'SMO','k-NN','C4.5','LMT','RandomForest'});