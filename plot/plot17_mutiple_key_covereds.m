x = [1 2 3 4];
y = [70.16 79.94 85.64 88.45];
plot(x,y,'-o');

text(x(1)-0.36,y(1)+2,'70.2');
text(x(2)-0.36,y(2)+2,'79.9');
text(x(3)-0.36,y(3)+2,'85.6');
text(x(4)-0.36,y(4)+2,'88.5');

ylabel('Prediction Accuracy/%');
xlabel('Key coverage');

