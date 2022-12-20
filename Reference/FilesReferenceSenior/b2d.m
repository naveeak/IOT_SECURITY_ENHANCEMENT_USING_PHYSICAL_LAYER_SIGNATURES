function cfo_b2d=b2d(b1,M)
n=9;
m=7;
d2b=b1;
b2d1 = d2b.*pow2(n-1:-1:-m);
cfo_b2d=sum(b2d1);