%拼装矩阵
clear;
L=0.1; %矩形边长
k=5; %热导率
tf1=80;
h1=50; %左边界的对流参数
tf2=30;
h2=100; %右边界的对流参数

N=50; %划分格子数目
d=L/N;

num=(N+1)*(N+1);

T=zeros(1,num);
A=zeros(num,num);
b=zeros(1,num);


%内部点
for i=2:N
    for j=2:N
        A((i-1)*(N+1)+j,(i-1)*(N+1)+j+1)=0.25;
         A((i-1)*(N+1)+j,(i-1)*(N+1)+j-1)=0.25;
          A((i-1)*(N+1)+j,(i-2)*(N+1)+j)=0.25;
           A((i-1)*(N+1)+j,i*(N+1)+j)=0.25;
    end
end

%上边界绝热
for i=2:N
    A((i-1)*(N+1)+N+1,(i-2)*(N+1)+N+1)=0.25;
    A((i-1)*(N+1)+N+1,i*(N+1)+N+1)=0.25;
    A((i-1)*(N+1)+N+1,(i-1)*(N+1)+N)=0.5;
end

%下边界恒定温度
for i=2:N
    b((i-1)*(N+1)+1)=120;
end

%左边界对流
for i=2:N
    A(i,N+1+i)=2/(h2*d/k +4);
    A(i,i+1)=1/(h2*d/k +4);
    A(i,i-1)=1/(h2*d/k +4);
    b(i)=(h2*d*tf2/k)/(h2*d/k +4);
end

%右边界对流

for i=2:N
    A(N*(N+1)+i,(N-1)*(N+1)+i)=2/(h1*d/k +4);
    A(N*(N+1)+i,N*(N+1)+i+1)=1/(h1*d/k +4);
    A(N*(N+1)+i,N*(N+1)+i-1)=1/(h1*d/k +4);
    b(N*(N+1)+i)=(h1*d*tf1/k)/(h1*d/k +4);
end

%角点
%t11
A(1,(N+1)+1)=1/(h2*d/k + 2);
A(1,2)=1/(h2*d/k +2 );
b(1)=(d*h2*tf2/k)/(h2*d/k +2);
%t1(N+1)
A(N+1,N)=1/(h2*d/k + 2);
A(N+1,(N+1)+N+1)=1/(h2*d/k + 2);
b(N+1)=(d*h2*tf2/k)/(h2*d/k +2);
%t(N+1)1
A(N*(N+1)+1,(N-1)*(N+1)+1)=1/(h1*d/k + 2);
A(N*(N+1)+1,N*(N+1)+2)=1/(h1*d/k + 2);
b(N*(N+1)+1)=(d*h1*tf1/k)/(h1*d/k +2);
%t(N+1)(N+1)
A(N*(N+1)+N+1,(N-1)*(N+1)+N+1)=1/(h1*d/k + 2);
A(N*(N+1)+N+1,N*(N+1)+N)=1/(h1*d/k + 2);
b(N*(N+1)+N+1)=(d*h1*tf1/k)/(h1*d/k +2);




 AA=eye(num)-A;
 x=b/AA;
%x1= Gauss(AA,b);
 %x0=zeros(1,num);
 %x2=GS(AA,b,x0,0.1,500);
%x3 = SOR(AA,b,0.1,500);

t=zeros(N+1,N+1);
for i=1:N+1
    for j=1:N+1
        t(i,j)=x((i-1)*(N+1)+j);
    end
end

mesh(t');
     

