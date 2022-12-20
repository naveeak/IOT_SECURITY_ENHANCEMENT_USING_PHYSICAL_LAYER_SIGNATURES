function tldc=tldc(csi,no_of_taps,bucket_size,offset)
csi=abs(csi);

%Initializing Buckets
differential_csi=zeros(1,no_of_taps);

%differential csi vector
for i=1:no_of_taps-1
    differential_csi(i)=csi(i+1)-csi(i);
end
n2=1;
no_of_buckets=no_of_taps/bucket_size;

%creating buckets
for j=1:no_of_buckets
    for j1=1:bucket_size
        bucket_matrix(j,j1)=differential_csi(n2);
        n2=n2+1;
    end
end
dmax=max(differential_csi);
dmin=min(differential_csi);

%four shape pattern vectors
for i=1:bucket_size
    v(1,i)=i*dmin/no_of_taps;
    v(3,i)=i*dmax/no_of_taps;
end
for j=bucket_size:-1:1
    v(2,bucket_size-j+1)=j*dmin/no_of_taps;
    v(4,bucket_size-j+1)=j*dmax/no_of_taps;
end

%frechet distances
n2=1;
for i=1:no_of_taps/bucket_size
    for n1=1:4
    for j=1:bucket_size
        ds1(j)=abs(bucket_matrix(i,j)-v(n2,j));
    end
    ds2=max(ds1);
    if(i>1 && n1>1)
        max1=max(frechet(i-1,n1),frechet(i,n1-1));
        max2=max(max1,frechet(i-1,n1-1));
        frechet(i,n1)=min(ds2,max2);
    else
        frechet(i,n1)=ds2;
    end
    n2=n2+1;
    end
    n2=1;
end
frechet_matrix=frechet.';
f1=min(frechet_matrix);
key=[];

%secret key k
for i=1:no_of_buckets
    for j=1:4
        if(f1(i)==frechet_matrix(j,i));
            v1=(v(j,1:end));
            for k=1:bucket_size
                tldc_d2b=d2b(v1(k));
                key=[key tldc_d2b];
            end
            break;
        end
    end
end
key_size=length(key);
%CFO Injection
M=16;         
s1=(2*no_of_taps)/(M*bucket_size); %cfo injection length
cfo_length=floor(s1);
ind=1;
for i=0:M:key_size-M
    b1=key(i+1:i+M);
    cfo_b2d=b2d(b1);
    k1(ind)=cfo_b2d;
    ind=ind+1;
end
k2=k1*offset;
k3=abs(k2);
key_final=k3(1:cfo_length);
tldc=sort(key_final);

