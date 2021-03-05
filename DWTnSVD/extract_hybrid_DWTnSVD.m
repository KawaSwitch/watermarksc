function [result] = extract_hybrid_DWTnSVD(Image,Sign,EmbedImage,a,t)


if size(Image) < size(Sign) / 2 
    disp('�T�C�Y������܂���B���摜�̃T�C�Y�͓��������̂Q�{�K�v�ł��B')
    disp(['���摜 : ',num2str(size(Image)) ,', ��������� : ', num2str(size(Sign))]);
    return;
elseif size(Image) > size(Sign) * 2
    Sign = padarray(Sign,size(Image) / 2 - size(Sign),1,'post');
end

% ���ߍ��ݎ菇��Step1����Step4�����s
[cA, cH, cV, cD] = dwt2(Image,'haar');
[U_LL, S_LL, V_LL] = svd(cA);
S_LL_D = S_LL + a * double(Sign);
[U_SS_L, S_SS_L, V_SS_L] = svd(S_LL_D);



%Step 1. ����������摜��DWT
[LL_W,cH_W,cV_W,cD_W] = dwt2(EmbedImage,'haar');

%Step 2. "����������摜��DWT���ē���ꂽLL�̈�LL_W"��SVD��K�p
[U_W,S_W,V_W] = svd(LL_W);

%Step3. ���ߍ��ݎ菇Step4�ŋ��߂�U_SS_L��V_SS_L�ƒ��o�菇Step2�ŋ��߂�S_W���g���āA�č\�����ꂽLL�̈�Construct_S_LLD�𓾂�
Construct_S_LLD = U_SS_L * S_W * V_SS_L.';
%Construct_S_LLD = LL_W;

%Step4. �������摜�𒊏o���邽�߂̏����B
Construct_W = (Construct_S_LLD - S_LL) / a;

%Step5. �������𒊏o����B臒l�œ������̗L�薳���𔻒肷��
Construct_W (Construct_W > t) = 255;
Construct_W (Construct_W <= t) = 0;

result = Construct_W;

