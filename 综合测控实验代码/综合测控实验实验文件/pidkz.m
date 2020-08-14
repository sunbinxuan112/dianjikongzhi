global numSpeed;
global numTarget;
global axes2handles;
global handles2;
global numPGain numIGain numDGain;
global SumError LastError PreError;
global HisIndex HisWave;
global P P1;
global sCom;
j=sign(numTarget);%判断转速符号
numSpeed=j*str2double(get(handles2,'string'));%取测量转速，反转取负号
Error=numTarget-numSpeed;%本次误差
SumError=SumError+Error;%积分误差
dError=LastError-PreError;%微分误差
PreError=LastError;%上次误差
LastError=Error;%当前误差偏量
HisWave(HisIndex)=j*numSpeed;%记录各点转速绝对值
plot(axes2handles,HisWave);%画实际转速曲线
HisIndex=HisIndex+1;%横坐标加一
Speed=numPGain*Error+SumError*numIGain+dError*numDGain;%PID速度反馈
if j==1%判断正反转曲线
gdp2=polyval(P,Speed);%获取高电平时间
else
gdp2=polyval(P1,Speed);%获取高电平时间
end% 高电平时间反馈范围
if ((gdp2<=2100) && (gdp2>=800))
gbw=floor(gdp2/256);%取高八位
dbw=mod(gdp2,256);%取低八位
tx=[85 5 251 gbw dbw 170];%十六进制文本
fwrite(sCom,tx,'uchar');%传输高电平时间
end
%created only by sunbinxuan
