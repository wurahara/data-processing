% Android
x=[1 2 3 4 5 6 7 8 9 10];
y=[78.0 55.0 34.0 51.0 45.0 41.0 59.6 44.4 62.0 76.0];

b = bar(x,y);

text(x(1)-0.36,y(1)+2,'78.0');
text(x(2)-0.36,y(2)+2,'55.0');
text(x(3)-0.36,y(3)+2,'34.0');
text(x(4)-0.36,y(4)+2,'51.0');
text(x(5)-0.36,y(5)+2,'45.0');
text(x(6)-0.36,y(6)+2,'41.0');
text(x(7)-0.36,y(7)+2,'59.6');
text(x(8)-0.36,y(8)+2,'44.4');
text(x(9)-0.36,y(9)+2,'62.0');
text(x(10)-0.36,y(10)+2,'76.0');


b.FaceColor = [0.6 0.6 0.6];
ylabel('Ԥ��׼ȷ��/%');
xlabel('����');
set(gca,'xticklabel',{'1','2','3','4','5','6','7','8','9','0'});
