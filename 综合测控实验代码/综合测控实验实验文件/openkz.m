function openkz()
global HisIndex1 HisWave1;
global numTarget;
global axes2handles;
global numSpeed;
global handles2;
j=sign(numTarget)%判定转速度符号
numSpeed=j*str2double(get(handles2,'string'));%取测量转速
HisWave1(HisIndex1)=j*numSpeed;%记录各点转速绝对值
plot(axes2handles,HisWave1);%画转速曲线
HisIndex1=HisIndex1+1;%横坐标加一
%created only by sunbinxuan