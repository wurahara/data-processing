x1 = [0:0.01:12];
p = raylpdf(x1,3);
d = fliplr(p);
plot(x1,d,'k','linewidth',1.5);