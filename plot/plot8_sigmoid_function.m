x = -6 :0.001: 6;
y = 1 ./ (1 + exp(-x));


plot(x, y,'LineWidth',2);
set(gca,'YAxisLocation','origin')