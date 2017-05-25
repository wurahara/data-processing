x=-20:0.1:20;
y1=gaussmf(x,[3 0]);
y2 =gaussmf(x,[5 0]);
y3 =gaussmf(x,[7 0]);
y4 =gaussmf(x,[9 0]);



plot(x,y1,'k-','linewidth', 1.5)
hold on
plot(x, y2,'k--','linewidth', 1.5);
hold on
plot(x, y3,'k-.','linewidth', 1.5);
hold on
plot(x, y4,'k:','linewidth', 1.5);
legend('3.90','2.08','1.59','1.54');
k1 = kurtosis(y1,0);
k2 = kurtosis(y2,0);
k3 = kurtosis(y3,0);
k4 = kurtosis(y4,0);