function getdata()
%����ȫ�ֱ���
global axeshandles;
global HDAQ;
global f1;
global f1z;
global A;
global d1;
global data;
global handles1;
global handles2;
data=USBDAQ8_ReadData_Continue(HDAQ,1000,5);%�ɼ��ź�
m=mean(data(1:1000,5));%-1500;%��ƽ��ֵ
y10=max(data(1:1000,5));%�����ֵ
y11=min(data(1:1000,5));%����Сֵ
y12=y10-y11;%���ֵ
dt=1/d1;%��������ʱ��
N=1000;%��������
T=inf;%��ʼ���������
plot(axeshandles,data(1:1000,5));%������������
%�������ع����ⷨ
n1=0;
for W=2:999
   if ((data(W-1,5)-m)<0) & ((data(W,5)-m)>=0) & ((data(W+1,5)-m)>0) 
       n1=n1+1;%����������
       A(n1)=W;%����������������Ӧ������
   end
end
if n1>0
    T=((A(n1)-A(1))*dt)/(n1-1);%������
end

f1=1.0/T;%��Ƶ��
f1z=f1*60/16;%��ת��
if y12<1000%�����˲����ж��Ƿ�Ϊ�����ź�
    f1z=0;%�����������ת��Ϊ0
end
set(handles1,'string',num2str(f1));%��ʾƵ��
set(handles2,'string',num2str(f1z));%��ʾת��
%created only by sunbinxuan

