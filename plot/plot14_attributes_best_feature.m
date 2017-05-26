x=[1 2 3 4 5 6 7 8 9 10 11];
y=[3 8 3 4 6 1 1 5 3 3 3];
b = bar(x,y);
str = {'3';'8';'3';'4';'6';'1';'1';'5';'3';'3';'3'};
ylim([0 10]);

for i = 1:11
text(x(i)-0.07,y(i)+0.2,str(i), 'fontsize', 18);
end

b.FaceColor = [0.6 0.6 0.6];
ylabel('Arributes','fontsize', 20);
xlabel('Feature','fontsize', 20);
set(gca,'xticklabel',{'Max','Min','RMS','RMSE','Mean','PeakNum','CrestNum','SMA','Skewness','Kurtosis','ATP/ATC'});
 