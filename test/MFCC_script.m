%% filter bank definition
load('mat_interped_test.mat');
sig = mat_test;
length = size(sig, 1);

total_time = mat(Length, 1) - mat(1, 1);
total_time = total_time * 24 * 60 * 60;

fs = length / total_time;                   % Sampling Frequency
Period = 1 / fs;                            % Sampling Period

Time_vector = mat(:,1);                     % Time vector
acc_x = sig(:,3);

bank=melbankm(24,256,fs,0,0.4,'t'); %Mel�˲����Ľ���Ϊ24��FFT�任�ĳ���Ϊ256������Ƶ��Ϊ16000Hz  
%��һ��Mel�˲�����ϵ��  
bank=full(bank); %full() convert sparse matrix to full matrix  
bank=bank/max(bank(:));  
for k=1:12  
    n=0:23;  
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));  
end  
w=1+6*sin(pi*(1:12)./12);%��һ��������������  
w=w/max(w);%Ԥ�����˲���  

%%
xx=double(x);  
xx=filter(1-0.9375,1,xx);%�����źŷ�֡  
xx=enframe(xx,256,80);%��xx 256���Ϊһ֡  
%����ÿ֡��MFCC����  
for i=1:size(xx,1)  
    y=xx(i,:);  
    s=y'.*hamming(256);  
    t=abs(fft(s));%FFT���ٸ���Ҷ�任  
    t=t.^2;  
    c1=dctcoef*log(bank*t(1:129));  
    c2=c1.*w';  
    m(i,:)=c2;  
end

%%
% %% ��һ�ײ��ϵ��
% dtm=zeros(size(m));  
% for i=3:size(m,1)-2  
%     dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);  
% end  
% dtm=dtm/3;  
% %��ȡ���ײ��ϵ��  
% dtmm=zeros(size(dtm));  
% for i=3:size(dtm,1)-2  
%     dtmm(i,:)=-2*dtm(i-2,:)-dtm(i-1,:)+dtm(i+1,:)+2*dtm(i+2,:);  
% end  
% dtmm=dtmm/3;  
% 
% %% �ϲ�mfcc������һ�ײ��mfcc����  
% ccc=[m dtm dtmm];  
% %ȥ����β��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0  
% ccc=ccc(3:size(m,1)-2,:);  
% ccc;  
% subplot(2,1,1);  
% ccc_1=ccc(:,1);  
% plot(ccc_1);title('MFCC');ylabel('��ֵ');  
% [h,w]=size(ccc);  
% A=size(ccc);  
% subplot(2,1,2);  
% plot([1,w],A);  
% xlabel('ά��');ylabel('��ֵ');  
% title('ά�����ֵ�Ĺ�ϵ');  