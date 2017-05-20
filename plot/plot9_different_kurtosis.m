x=-30:0.1:30;
y1=gaussmf(x,[2 0]);
y2 =gaussmf(x,[4 0]);
y3 =gaussmf(x,[6 0]);
y4 =gaussmf(x,[8 0]);



plot(x,y1,'k-')
hold on
plot(x, y2,'k--');
hold on
plot(x, y3,'k-.');
hold on
plot(x, y4,'k:');
legend('10.40','4.51','2.70','1.94');
k1 = kurtosis(y1,0);
k2 = kurtosis(y2,0);
k3 = kurtosis(y3,0);
k4 = kurtosis(y4,0);