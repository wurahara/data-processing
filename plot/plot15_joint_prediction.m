x=[1,2];
y=[62.1,54.6; 63.7,56.3; 70.2,61.5]';
b = bar(x,y);

b(1).FaceColor = [0.6 0.6 0.6];
b(2).FaceColor = [0.75 0.75 0.75];
b(3).FaceColor = [0.9 0.9 0.9];


text(0.75,64.2,num2str(62.1));
text(0.95,65.8,num2str(63.7));
text(1.16,72.2,num2str(70.2));

text(1.8,56.8,num2str(54.6));
text(2.1,58.4,num2str(56.3));
text(2.1,63.6,num2str(61.5));

ylabel('Prediction Accuracy/%');
legend('LMT','Simple Voting','Joint Prediction');
set(gca,'xticklabel',{'iPhone 6s','MI 3'});