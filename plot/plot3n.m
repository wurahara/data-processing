x = rand(100,1);
[n,y] = hist(x);
bar(y,n);
for i = 1:length(y)
text(y(i),n(i)+0.5,num2str(n(i)));
end