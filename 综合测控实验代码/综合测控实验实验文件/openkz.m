function openkz()
global HisIndex1 HisWave1;
global numTarget;
global axes2handles;
global numSpeed;
global handles2;
j=sign(numTarget)%�ж�ת�ٶȷ���
numSpeed=j*str2double(get(handles2,'string'));%ȡ����ת��
HisWave1(HisIndex1)=j*numSpeed;%��¼����ת�پ���ֵ
plot(axes2handles,HisWave1);%��ת������
HisIndex1=HisIndex1+1;%�������һ
%created only by sunbinxuan