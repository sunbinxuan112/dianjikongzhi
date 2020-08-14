function getdata()
%定义全局变量
global axeshandles;
global HDAQ;
global f1;
global f1z;
global A;
global d1;
global data;
global handles1;
global handles2;
data=USBDAQ8_ReadData_Continue(HDAQ,1000,5);%采集信号
m=mean(data(1:1000,5));%-1500;%求平均值
y10=max(data(1:1000,5));%求最大值
y11=min(data(1:1000,5));%求最小值
y12=y10-y11;%求幅值
dt=1/d1;%求采样间隔时间
N=1000;%采样点数
T=inf;%初始周期无穷大
plot(axeshandles,data(1:1000,5));%画出采样波形
%上脉冲沿过零检测法
n1=0;
for W=2:999
   if ((data(W-1,5)-m)<0) & ((data(W,5)-m)>=0) & ((data(W+1,5)-m)>0) 
       n1=n1+1;%上跳变点个数
       A(n1)=W;%完整周期上跳变点对应采样点
   end
end
if n1>0
    T=((A(n1)-A(1))*dt)/(n1-1);%求周期
end

f1=1.0/T;%求频率
f1z=f1*60/16;%求转速
if y12<1000%简易滤波器判断是否为噪声信号
    f1z=0;%如果是噪声则转速为0
end
set(handles1,'string',num2str(f1));%显示频率
set(handles2,'string',num2str(f1z));%显示转速
%created only by sunbinxuan

