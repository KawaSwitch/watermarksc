

function [result] = emb_hybrid_DWTnSVD(Image,Sign,a)

if size(Image) < size(Sign) / 2 
    disp('�T�C�Y������܂���B���摜�̃T�C�Y�͓��������̂Q�{�K�v�ł��B')
    disp(['���摜 : ',num2str(size(Image)) ,', ��������� : ', num2str(size(Sign))]);
    return;
elseif size(Image) > size(Sign) * 2
    Sign = padarray(Sign,size(Image) / 2 - size(Sign),1,'post'); 
end

%Step 1. ���摜��DWT�ϊ�����
[LL, cH, cV, cD] = dwt2(Image,'haar');

%Step 2. LL��SVD��K�p
[U_LL, S_LL, V_LL] = svd(LL);


%Step 3. S_LL�ɓ������𖄂ߍ���
S_LL_D = S_LL + a * double(Sign);

%Step 4. S_LL_D��SVD��K�p
[U_SS_L, S_SS_L, V_SS_L] = svd(S_LL_D);

%Step 5. S_SS_L��Step 2.�ŋ��߂�U_LL,V_LL��p���A�����������ߍ��܂ꂽLL�̈�(LL_SVD)�𕜌�
LL_SVD = U_LL * S_SS_L * V_LL.';

%Step 6. �����������ߍ��܂ꂽLL�̈�(LL_SVD)���g���ċtDWT���s��
EmbedImage = uint8( idwt2(LL_SVD,cH,cV,cD,'haar') );


result=EmbedImage;

