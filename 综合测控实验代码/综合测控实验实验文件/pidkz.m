global numSpeed;
global numTarget;
global axes2handles;
global handles2;
global numPGain numIGain numDGain;
global SumError LastError PreError;
global HisIndex HisWave;
global P P1;
global sCom;
j=sign(numTarget);%�ж�ת�ٷ���
numSpeed=j*str2double(get(handles2,'string'));%ȡ����ת�٣���תȡ����
Error=numTarget-numSpeed;%�������
SumError=SumError+Error;%�������
dError=LastError-PreError;%΢�����
PreError=LastError;%�ϴ����
LastError=Error;%��ǰ���ƫ��
HisWave(HisIndex)=j*numSpeed;%��¼����ת�پ���ֵ
plot(axes2handles,HisWave);%��ʵ��ת������
HisIndex=HisIndex+1;%�������һ
Speed=numPGain*Error+SumError*numIGain+dError*numDGain;%PID�ٶȷ���
if j==1%�ж�����ת����
gdp2=polyval(P,Speed);%��ȡ�ߵ�ƽʱ��
else
gdp2=polyval(P1,Speed);%��ȡ�ߵ�ƽʱ��
end% �ߵ�ƽʱ�䷴����Χ
if ((gdp2<=2100) && (gdp2>=800))
gbw=floor(gdp2/256);%ȡ�߰�λ
dbw=mod(gdp2,256);%ȡ�Ͱ�λ
tx=[85 5 251 gbw dbw 170];%ʮ�������ı�
fwrite(sCom,tx,'uchar');%����ߵ�ƽʱ��
end
%created only by sunbinxuan
