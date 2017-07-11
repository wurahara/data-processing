x=[1,2];
y=[62.1,54.6; 8.1,6.91]';
b = bar(x,y,'stacked');

b(1).FaceColor = [0.6 0.6 0.6];
b(2).FaceColor = [0.9 0.9 0.9];


text(0.95,64.2,num2str(62.1));
text(1.95,56.8,num2str(54.6));

text(0.95,72.2,num2str(70.2));
text(1.95,63.6,num2str(61.5));

ylabel('Prediction Accuracy/%');
legend('LMT','Joint Prediction');
set(gca,'xticklabel',{'iPhone 6s','MI 3'});