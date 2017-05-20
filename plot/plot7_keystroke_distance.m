x=[0 1 2 3 4];
y=[62.14 26.89 8.86 1.80 0.30];
b = bar(x,y);
str = {'62.14';'26.89';'8.86';'1.80';'0.30'};
for i = 1:2
text(x(i)-0.18,y(i)+3, str(i) );
end

for i = 3:5
text(x(i)-0.13,y(i)+3, str(i) );
end

b.FaceColor = [0.6 0.6 0.6];
ylabel('°´¼üÔ¤²â¸ÅÂÊ/%');
xlabel('°´¼ü¾àÀë');
set(gca,'xticklabel',{'0','1','2','3','4'});