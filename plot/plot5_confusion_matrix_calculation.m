a = [151   1   0   0   0   3   5  15  20   5 ;
   0 169   1   0  27   1   0   1   0   1 ;
   3   4 126   7  17  26   1  12   1   3 ;
   3   3  15  62   0  29  36   4  22  25 ;
   0  26  20   2 125   2   0  25   0   0 ;
  13   1  39   9   9  84   4   4  32   5 ;
  10   0   4  26   2  20  60   4  26  47 ;
  13   1   8   2  17   4   0 151   2   2 ;
  20   1   7  10   1  33  15   2  92  19 ;
  15   0   4  27   0   8  41   6  21  77]


p = [];
for i = 1: 10
    p(i) = sum(a(i,:));
end

all = [];
for q = 1 : 10
    for k = 1 : 10
        all(q,k) = a(q,k)/p(q) * 100;
    end
end
